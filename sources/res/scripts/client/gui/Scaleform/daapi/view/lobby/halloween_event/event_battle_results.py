import SoundGroups, constants
from adisp import process
from gui.impl.lobby.halloween.event_helpers import notifyCursorOver3DScene
from gui.prb_control import prbDispatcherProperty, prbEntityProperty
from gui.prb_control.events_dispatcher import g_eventDispatcher
from gui.sounds.sound_constants import HW21SoundConsts
from helpers import dependency
from gui.Scaleform.daapi.view.meta.EventBattleResultScreenMeta import EventBattleResultScreenMeta
from gui.shared import event_bus_handlers, events, EVENT_BUS_SCOPE, event_dispatcher
from CurrentVehicle import g_currentVehicle
from gui.sounds.ambients import BattleResultsEnv
from messenger.proto.events import g_messengerEvents
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.battle_results import IBattleResultsService
from skeletons.gui.shared.utils import IHangarSpace
from skeletons.gui.server_events import IEventsCache
from messenger.m_constants import PROTO_TYPE, USER_TAG
from messenger.storage import storage_getter
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
from messenger.proto import proto_getter
from helpers.CallbackDelayer import CallbackDelayer
_SNDID_ACHIEVEMENT = 'result_screen_achievements'
_SNDID_BONUS = 'result_screen_bonus'
_CHECK_FRIEND_TIMEOUT = 5.0
_KEYS_RESULT_TO_EXCLUDE = ('hw21NarrativeInfo', )

class EventBattleResult(EventBattleResultScreenMeta, CallbackDelayer):
    battleResults = dependency.descriptor(IBattleResultsService)
    appLoader = dependency.descriptor(IAppLoader)
    hangarSpace = dependency.descriptor(IHangarSpace)
    eventsCache = dependency.descriptor(IEventsCache)
    __sound_env__ = BattleResultsEnv
    __metaclass__ = event_bus_handlers.EventBusListener

    def __init__(self, ctx=None):
        super(EventBattleResult, self).__init__()
        if 'arenaUniqueID' not in ctx:
            raise UserWarning('Key "arenaUniqueID" is not found in context', ctx)
        if not ctx['arenaUniqueID']:
            raise UserWarning('Value of "arenaUniqueID" must be greater than 0')
        self.__arenaUniqueID = ctx['arenaUniqueID']
        self.__isResultsSet = False

    @prbDispatcherProperty
    def prbDispatcher(self):
        return

    @prbEntityProperty
    def prbEntity(self):
        return

    @storage_getter('users')
    def usersStorage(self):
        return

    @proto_getter(PROTO_TYPE.MIGRATION)
    def proto(self):
        return

    @property
    def isInEventMode(self):
        if self.prbDispatcher:
            state = self.prbDispatcher.getFunctionalState()
            return state.isInUnit(constants.PREBATTLE_TYPE.EVENT) or state.isInPreQueue(constants.QUEUE_TYPE.EVENT_BATTLES)
        return False

    def closeView(self):
        if self.prbDispatcher and self.prbDispatcher.getEntity().isInQueue():
            if self.isInEventMode:
                g_eventDispatcher.loadEventBattleQueue()
            else:
                g_eventDispatcher.loadBattleQueue()
        else:
            event_dispatcher.showHangar()
        self.destroy()

    def playSliderSound(self):
        SoundGroups.g_instance.playSound2D(HW21SoundConsts.HANGAR_PBS_SLIDER)

    def playPointsSound(self):
        SoundGroups.g_instance.playSound2D(HW21SoundConsts.HANGAR_PBS_MAIN_POINTS)

    def playQuestSound(self):
        SoundGroups.g_instance.playSound2D(HW21SoundConsts.HANGAR_PBS_QUEST)

    def playRewardSound(self):
        SoundGroups.g_instance.playSound2D(HW21SoundConsts.HANGAR_PBS_REWARD)

    def playProgressBarSound(self):
        SoundGroups.g_instance.playSound2D(HW21SoundConsts.HANGAR_PBS_PROGRESSBAR)

    @event_bus_handlers.eventBusHandler(events.HideWindowEvent.HIDE_BATTLE_RESULT_WINDOW, EVENT_BUS_SCOPE.LOBBY)
    def selectVehicle(self, inventoryId):
        g_currentVehicle.selectVehicle(inventoryId)
        return g_currentVehicle.invID == inventoryId

    @process
    def addToSquad(self, databaseID):
        result = False
        if self.eventsCache.isEventEnabled():
            result = yield self.prbDispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.EVENT_SQUAD, accountsToInvite=(databaseID,), keepCurrentView=True))
        self.as_addToSquadResultS(result, databaseID)

    def addToFriend(self, databaseID, userName):
        self.proto.contacts.addFriend(databaseID, userName)
        self.delayCallback(_CHECK_FRIEND_TIMEOUT, self.__checkFriendOnDelay, databaseID)

    def _populate(self):
        super(EventBattleResult, self)._populate()
        if self.battleResults.areResultsPosted(self.__arenaUniqueID):
            self.__setBattleResults()
        else:
            self.battleResults.onResultPosted += self.__handleBattleResultsPosted
        if not self.hangarSpace.spaceInited:
            self.hangarSpace.onSpaceCreate += self.__onHangarSpaceCreated
        g_messengerEvents.users.onUserActionReceived += self.__onUserActionReceived
        g_messengerEvents.users.onUserStatusUpdated += self.__onUserStatusUpdated
        self.fireEvent(events.HangarVehicleEvent(events.HangarVehicleEvent.HERO_TANK_MARKER, ctx={'isDisable': True}), EVENT_BUS_SCOPE.LOBBY)
        notifyCursorOver3DScene(False)

    def _dispose(self):
        g_messengerEvents.users.onUserActionReceived -= self.__onUserActionReceived
        g_messengerEvents.users.onUserStatusUpdated -= self.__onUserStatusUpdated
        self.battleResults.onResultPosted -= self.__handleBattleResultsPosted
        self.hangarSpace.onSpaceCreate -= self.__onHangarSpaceCreated
        self.fireEvent(events.HangarVehicleEvent(events.HangarVehicleEvent.HERO_TANK_MARKER, ctx={'isDisable': False}), EVENT_BUS_SCOPE.LOBBY)
        self.clearCallbacks()
        super(EventBattleResult, self)._dispose()

    def __onUserActionReceived(self, _, user, __):
        self.__checkFriendAdded(user)

    def __onUserStatusUpdated(self, user):
        self.__checkFriendAdded(user)

    def __getBattleResults(self):
        vo = self.battleResults.getResultsVO(self.__arenaUniqueID)
        for key in _KEYS_RESULT_TO_EXCLUDE:
            if key in vo:
                del vo[key]

        return vo

    def __setBattleResults(self):
        if self.__isResultsSet:
            return
        self.__isResultsSet = True
        canCreateSquad = self.prbEntity.getPermissions().canCreateSquad()
        canInvite = self.prbEntity.getPermissions().canSendInvite()
        isEventEnable = self.eventsCache.isEventEnabled()
        vo = self.__getBattleResults()
        friends = self.__getFriendsFromStats(vo)
        self.as_setVictoryDataS(vo, (canCreateSquad or canInvite) and isEventEnable, friends)
        if self.hangarSpace.spaceInited:
            self.as_playAnimationS()

    def __handleBattleResultsPosted(self, reusableInfo, composer, window):
        if self.__arenaUniqueID == reusableInfo.arenaUniqueID:
            self.battleResults.onResultPosted -= self.__handleBattleResultsPosted
            self.hangarSpace.onSpaceCreate -= self.__onHangarSpaceCreated
            self.__setBattleResults()

    def __onHangarSpaceCreated(self):
        self.as_playAnimationS()

    def __getFriendsFromStats(self, vo):
        players = vo['players']
        result = []
        for player in players:
            playerId = player['playerId']
            user = self.usersStorage.getUser(playerId)
            if user is not None and user.isFriend():
                result.append(playerId)

        return result

    def __checkFriendOnDelay(self, databaseID):
        user = self.usersStorage.getUser(databaseID)
        self.__checkFriendAdded(user)

    def __checkFriendAdded(self, user):
        isFriend = user is not None and user.isFriend()
        isPending = USER_TAG.SUB_PENDING_OUT in user.getTags() if isFriend else False
        self.as_addToFriendResultS(user.getID(), isFriend, isPending)
        return