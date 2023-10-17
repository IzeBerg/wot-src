import logging
from adisp import adisp_process
from constants import DEATH_REASON_ALIVE
from frameworks.wulf import ViewFlags, ViewSettings, WindowStatus
from gui.impl.backport import createContextMenuData, BackportContextMenuWindow
from gui.prb_control import prbInvitesProperty
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.entities.listener import IGlobalListener
from halloween.gui.impl.gen.view_models.views.common.stat_column_settings_model import ColumnEnum
from halloween.gui.impl.gen.view_models.views.battle.event_stats_view_model import EventStatsViewModel
from halloween.gui.impl.gen.view_models.views.common.base_team_member_model import TeamMemberBanType
from halloween.gui.impl.gen.view_models.views.battle.event_stats_team_member_model import EventStatsTeamMemberModel
from gui.impl.pub import ViewImpl
from gui.impl.gen import R
from halloween.gui.scaleform.genConsts.HALLOWEEN_CM_HANDLER_TYPE import HALLOWEEN_CM_HANDLER_TYPE
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency
from messenger.m_constants import UserEntityScope, USER_TAG, PROTO_TYPE
from messenger.proto import proto_getter
from messenger.proto.entities import SharedUserEntity
from messenger.proto.events import g_messengerEvents
from messenger.storage import storage_getter
from skeletons.gui.battle_results import IBattleResultsService
from skeletons.gui.game_control import IPlatoonController
from messenger.proto.entities import ClanInfo as UserClanInfo
from gui.prb_control.settings import PRB_INVITE_STATE
from halloween.gui.halloween_gui_constants import PREBATTLE_ACTION_NAME
from halloween_common.halloween_constants import PREBATTLE_TYPE
from skeletons.gui.lobby_context import ILobbyContext
from helpers.CallbackDelayer import CallbackDelayer
_CHECK_FRIEND_TIMEOUT = 5.0
_DEFAULT_CONTEXT_MENU_PLAYER_ID = -1
_logger = logging.getLogger(__name__)

class BattleResultStats(ViewImpl, IGlobalListener, CallbackDelayer):
    battleResults = dependency.descriptor(IBattleResultsService)
    platoonCtrl = dependency.descriptor(IPlatoonController)
    hwController = dependency.descriptor(IHalloweenController)
    lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self, arenaUniqueID, flags=ViewFlags.VIEW, *args, **kwargs):
        settings = ViewSettings(layoutID=R.views.halloween.sub_views.EventStats(), flags=flags, model=EventStatsViewModel())
        settings.args = args
        settings.kwargs = kwargs
        self.__arenaUniqueID = arenaUniqueID
        self.__contextMenuWindow = None
        super(BattleResultStats, self).__init__(settings)
        return

    def createContextMenu(self, event):
        if event.contentID == R.views.common.BackportContextMenu():
            dbID = event.getArgument('playerId')
            contextMenuArgs = {'dbID': dbID, 
               'userName': event.getArgument('userName'), 
               'clanAbbrev': event.getArgument('clanAbbrev'), 
               'vehicleCD': event.getArgument('vehicleCD'), 
               'isAlly': True, 
               'clientArenaIdx': event.getArgument('clientArenaIdx'), 
               'wasInBattle': True}
            contextMenuData = createContextMenuData(HALLOWEEN_CM_HANDLER_TYPE.HALLOWEEN_BATTLE_RESULTS, contextMenuArgs)
            self.__contextMenuWindow = BackportContextMenuWindow(contextMenuData, self.getParentWindow())
            self.__contextMenuWindow.onStatusChanged += self.__onStatusChangedContextMenu
            self.__contextMenuWindow.load()
            with self.viewModel.transaction() as (tx):
                tx.setContextMenuPlayerId(dbID)
            return self.__contextMenuWindow
        return super(BattleResultStats, self).createContextMenu(event)

    @property
    def viewModel(self):
        return super(BattleResultStats, self).getViewModel()

    @storage_getter('users')
    def usersStorage(self):
        return

    @proto_getter(PROTO_TYPE.MIGRATION)
    def proto(self):
        return

    @prbInvitesProperty
    def prbInvites(self):
        return

    def _finalize(self):
        self._removeEventListeners()
        self.__contextMenuWindow = None
        super(BattleResultStats, self)._finalize()
        return

    def _onLoading(self, *args, **kwargs):
        super(BattleResultStats, self)._onLoading(*args, **kwargs)
        self._addEventListeners()
        self.__updateView()

    def _onUserActionReceived(self, _, user, __):
        self.__checkUserStatusUpdate(user)

    def _onUserStatusUpdated(self, user):
        self.__checkUserStatusUpdate(user)

    def _addEventListeners(self):
        g_messengerEvents.users.onUserActionReceived += self._onUserActionReceived
        g_messengerEvents.users.onUserStatusUpdated += self._onUserStatusUpdated
        self.viewModel.onSendFriendRequest += self._sendFriendRequest
        self.viewModel.onSendPlatoonInvitation += self._sendPlatoonInvitation
        self.viewModel.onRemoveFromBlacklist += self._removeFromBlacklist
        invitesManager = self.prbInvites
        if invitesManager is not None:
            invitesManager.onSentInviteListModified += self._onSentInviteListModified
        self.platoonCtrl.onMembersUpdate += self._onMembersSquadUpdate
        return

    def _removeEventListeners(self):
        g_messengerEvents.users.onUserActionReceived -= self._onUserActionReceived
        g_messengerEvents.users.onUserStatusUpdated -= self._onUserStatusUpdated
        self.viewModel.onSendFriendRequest -= self._sendFriendRequest
        self.viewModel.onSendPlatoonInvitation -= self._sendPlatoonInvitation
        self.viewModel.onRemoveFromBlacklist -= self._removeFromBlacklist
        invitesManager = self.prbInvites
        if invitesManager is not None:
            invitesManager.onSentInviteListModified -= self._onSentInviteListModified
        self.platoonCtrl.onMembersUpdate -= self._onMembersSquadUpdate
        return

    def _sendFriendRequest(self, args=None):
        if not args:
            return
        else:
            dbID = int(args.get('playerId', 0))
            userName = args.get('userName')
            if not (dbID and userName):
                return
            if not self.lobbyContext.getServerSettings().roaming.isSameRealm(dbID):
                return
            user = self.usersStorage.getUser(dbID)
            if user is None:
                user = SharedUserEntity(dbID, name=userName, clanInfo=UserClanInfo(abbrev=args.get('clanAbbrev', '')), scope=UserEntityScope.LOBBY, tags={USER_TAG.SEARCH, USER_TAG.TEMP})
                self.usersStorage.addUser(user)
            if not user.isFriend():
                self.proto.contacts.addFriend(dbID, userName)
                self.delayCallback(_CHECK_FRIEND_TIMEOUT, self.__checkFriendOnDelay, dbID)
            elif self.proto.contacts.isBidiFriendshipSupported() and USER_TAG.SUB_NONE in user.getTags():
                self.proto.contacts.requestFriendship(dbID)
                self.delayCallback(_CHECK_FRIEND_TIMEOUT, self.__checkFriendOnDelay, dbID)
            return

    @adisp_process
    def _sendPlatoonInvitation(self, args):
        if not (args and self.hwController.isAvailable()):
            return
        dbID = args.get('playerId')
        if not dbID:
            return
        yield self.prbDispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.HALLOWEEN_SQUAD, accountsToInvite=(int(dbID),)))

    def _removeFromBlacklist(self, args=None):
        if not args:
            return
        dbID = args.get('playerId')
        if not dbID:
            return
        self.proto.contacts.removeIgnored(dbID)

    def _onSentInviteListModified(self, added, changed, deleted):
        if not self.hwController.isAvailable():
            return
        allChangedInvites = set(added) | set(changed) | set(deleted)
        for inviteID in allChangedInvites:
            invite = self.prbInvites.getInvite(inviteID)
            if invite.type != PREBATTLE_TYPE.HALLOWEEN:
                continue
            dbID = invite.receiverID
            state = invite.getState()
            self.__setStatusPlatoonRequestSent(dbID, state)

    def _onMembersSquadUpdate(self):
        with self.viewModel.transaction() as (tx):
            self.__fillViewModel(model=tx)

    def __onStatusChangedContextMenu(self, windowStatus):
        if windowStatus == WindowStatus.DESTROYED:
            with self.viewModel.transaction() as (tx):
                tx.setContextMenuPlayerId(_DEFAULT_CONTEXT_MENU_PLAYER_ID)
            self.__contextMenuWindow.onStatusChanged -= self.__onStatusChangedContextMenu
            self.__contextMenuWindow = None
        return

    def __isFriend(self, dbID):
        user = self.usersStorage.getUser(dbID)
        if user is None:
            return False
        else:
            tags = user.getTags()
            return user.isFriend() and USER_TAG.SUB_PENDING_OUT not in tags and USER_TAG.SUB_NONE not in tags

    def __isRequestFriendSent(self, dbID):
        user = self.usersStorage.getUser(dbID)
        if user is None:
            return False
        else:
            return USER_TAG.SUB_PENDING_OUT in user.getTags() and user.isFriend()

    def __isRequestSquadSent(self, dbID):
        for invite in self.prbInvites.getInvites(incoming=False):
            if invite.type != PREBATTLE_TYPE.HALLOWEEN or dbID != invite.receiverID:
                continue
            return invite.getState() == PRB_INVITE_STATE.PENDING

        return False

    def __isPlayerInSquad(self, dbID):
        if not self.platoonCtrl.isInPlatoon() or self.platoonCtrl.getPrbEntityType() != PREBATTLE_TYPE.HALLOWEEN:
            return False
        return dbID in self.prbEntity.getPlayers()

    def __isPlayerInIgnoreList(self, dbID):
        user = self.usersStorage.getUser(dbID)
        return user is not None and user.isIgnored()

    def __canCreateSquad(self):
        result = self.prbEntity.getPermissions().canCreateSquad() and self.hwController.isAvailable()
        if self.platoonCtrl.isInPlatoon() and self.platoonCtrl.getPrbEntityType() == PREBATTLE_TYPE.HALLOWEEN:
            result = result and self.prbEntity.getPermissions().canSendInvite()
        return result

    def __checkUserStatusUpdate(self, user):
        if user is None:
            return
        else:
            isFriend = self.__isFriend(user.getID())
            isPending = self.__isRequestFriendSent(user.getID())
            isIgnored = user is not None and user.isIgnored()
            with self.viewModel.transaction() as (tx):
                for member in tx.getTeam():
                    if not member.getPlayerId() == user.getID():
                        continue
                    member.setIsFriendRequestSent(isPending)
                    member.setIsInFriendList(isFriend)
                    member.setIsBlacklisted(isIgnored)

            return

    def __setStatusPlatoonRequestSent(self, dbID, state):
        with self.viewModel.transaction() as (tx):
            for member in tx.getTeam():
                if member.getPlayerId() != dbID:
                    continue
                member.setIsPlatoonRequestSent(state == PRB_INVITE_STATE.PENDING)
                member.setIsPlatoonRequestCanBeMade(state != PRB_INVITE_STATE.ACCEPTED)

    def __checkFriendOnDelay(self, dbID):
        user = self.usersStorage.getUser(dbID)
        self.__checkUserStatusUpdate(user)

    def __setColumns(self, model=None):
        columns = model.columnSettings.getVisibleColumns()
        columns.clear()
        columns.addString(ColumnEnum.PLACE.value)
        columns.addString(ColumnEnum.KEYS.value)
        columns.addString(ColumnEnum.SOULS.value)
        columns.addString(ColumnEnum.DAMAGE.value)
        columns.addString(ColumnEnum.KILLS.value)
        columns.invalidate()

    def __makeTeamMemberModel(self, idx, playerVO):
        member = EventStatsTeamMemberModel()
        dbID = playerVO['playerDBID']
        member.setId(idx)
        member.setPlayerId(dbID)
        member.setIsCurrentPlayer(playerVO['isPlayer'])
        member.setIsOwnSquad(playerVO['isPlayer'] or playerVO['isOwnSquad'])
        member.setSquadNum(playerVO['squadID'])
        member.setBanType(TeamMemberBanType.NOTBANNED)
        member.setIsFriendRequestSent(self.__isRequestFriendSent(dbID))
        member.setIsInFriendList(self.__isFriend(dbID))
        member.setIsPlatoonRequestCanBeMade(self.__canCreateSquad() and not self.__isPlayerInSquad(dbID))
        member.setIsPlatoonRequestSent(self.__isRequestSquadSent(dbID))
        member.setIsBlacklisted(self.__isPlayerInIgnoreList(dbID))
        member.stats.setPlace(idx + 1)
        member.stats.setDamage(playerVO['damageDealt'])
        member.stats.setSouls(playerVO['soulsDelivered'])
        member.stats.setKeys(playerVO['artefactKeys'])
        member.stats.setKills(playerVO['kills'])
        member.setIsAlive(playerVO['deathReason'] == DEATH_REASON_ALIVE)
        member.user.setUserName(playerVO['playerName'])
        member.user.setClanAbbrev(playerVO['clanAbbrev'])
        member.user.setIsFakeNameVisible(False)
        badgeID = playerVO['badgeID']
        member.user.badge.setBadgeID(str(badgeID) if badgeID != 0 else '')
        badgeSuffixID = playerVO['badgeSuffixID']
        member.user.suffixBadge.setBadgeID(str(badgeSuffixID) if badgeSuffixID != 0 else '')
        member.vehicle.setVehicleName(playerVO['vehicleName'])
        member.vehicle.setVehicleType(playerVO['vehicleType'])
        member.vehicle.setVehicleLvl(playerVO['vehicleLvl'])
        member.vehicle.setVehicleCD(playerVO['vehicleCD'])
        return member

    def __fillViewModel(self, model):
        totalVO = self.battleResults.getResultsVO(self.__arenaUniqueID)
        teamModel = model.getTeam()
        teamModel.clear()
        for idx, playerVO in enumerate(totalVO['players']):
            member = self.__makeTeamMemberModel(idx, playerVO)
            teamModel.addViewModel(member)

        teamModel.invalidate()

    def __updateView(self):
        with self.viewModel.transaction() as (tx):
            self.__setColumns(model=tx)
            self.__fillViewModel(model=tx)