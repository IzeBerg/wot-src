import logging, typing, collections, weakref
from collections import defaultdict
from PlayerEvents import g_playerEvents
from account_helpers.account_completion import isEmailConfirmationRequired
from constants import ARENA_BONUS_TYPE, MAPS_TRAINING_ENABLED_KEY
from account_helpers import AccountSettings
from account_helpers.AccountSettings import PROGRESSIVE_REWARD_VISITED, SENIORITY_AWARDS_COUNTER
from adisp import process
from async import async, await
from chat_shared import SYS_MESSAGE_TYPE
from constants import AUTO_MAINTENANCE_RESULT, PremiumConfigs, DAILY_QUESTS_CONFIG, DOG_TAGS_CONFIG
from collector_vehicle import CollectorVehicleConsts
from debug_utils import LOG_DEBUG, LOG_ERROR
from gui import SystemMessages
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.Scaleform.locale.CLANS import CLANS
from gui.SystemMessages import SM_TYPE
from gui.battle_pass.battle_pass_helpers import getStyleInfoForChapter
from gui.clans.clan_account_profile import SYNC_KEYS
from gui.clans.clan_helpers import ClanListener, isInClanEnterCooldown
from gui.clans.settings import CLAN_APPLICATION_STATES
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.lobby.premacc.premacc_helpers import PiggyBankConstants, getDeltaTimeHelper
from gui.prb_control import prbInvitesProperty
from gui.prb_control.entities.listener import IGlobalListener
from gui.server_events.recruit_helper import getAllRecruitsInfo
from gui.shared import g_eventBus, events
from gui.shared.formatters import time_formatters, text_styles
from gui.shared.notifications import NotificationPriorityLevel
from gui.shared.utils import showInvitationInWindowsBar
from gui.shared.view_helpers.UsersInfoHelper import UsersInfoHelper
from gui.wgcg.clan.contexts import GetClanInfoCtx
from gui.wgnc import g_wgncProvider, g_wgncEvents, wgnc_settings
from gui.wgnc.settings import WGNC_DATA_PROXY_TYPE
from helpers import time_utils, i18n, dependency
from messenger.m_constants import PROTO_TYPE, USER_ACTION_ID
from messenger.proto import proto_getter
from messenger.proto.events import g_messengerEvents
from messenger.proto.xmpp.xmpp_constants import XMPP_ITEM_TYPE
from messenger.formatters import TimeFormatter
from notification import tutorial_helper
from notification.decorators import MessageDecorator, PrbInviteDecorator, C11nMessageDecorator, FriendshipRequestDecorator, WGNCPopUpDecorator, ClanAppsDecorator, ClanInvitesDecorator, ClanAppActionDecorator, ClanInvitesActionDecorator, ClanSingleAppDecorator, ClanSingleInviteDecorator, ProgressiveRewardDecorator, MissingEventsDecorator, RecruitReminderMessageDecorator, EmailConfirmationReminderMessageDecorator, LockButtonMessageDecorator
from notification.settings import NOTIFICATION_TYPE, NOTIFICATION_BUTTON_STATE
from shared_utils import first
from skeletons.gui.game_control import IBootcampController, IGameSessionController, IBattlePassController, IEventsNotificationsController
from skeletons.gui.impl import INotificationWindowController
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.login_manager import ILoginManager
from skeletons.gui.platform.wgnp_controller import IWGNPRequestController
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from gui.Scaleform.daapi.view.lobby.hangar.seniority_awards import getSeniorityAwardsBoxesCount
if typing.TYPE_CHECKING:
    from notification.NotificationsModel import NotificationsModel
_logger = logging.getLogger(__name__)

class _FeatureState(object):
    OFF = 0
    ON = 1


_FUNCTION = 'function'
SERVER_CMD_BP_GAMEMODE_ENABBLED = 'cmd_bp_gamemode_enabled'

class _StateExtractor(object):
    __lobbyContext = dependency.descriptor(ILobbyContext)

    @classmethod
    def getAdditionalBonusState(cls):
        return cls.__lobbyContext.getServerSettings().getAdditionalBonusConfig().get('enabled')

    @classmethod
    def getPiggyBankState(cls):
        return cls.__lobbyContext.getServerSettings().getPiggyBankConfig().get('enabled')

    @classmethod
    def getPremQuestsState(cls):
        return cls.__lobbyContext.getServerSettings().getPremQuestsConfig().get('enabled')

    @classmethod
    def getSquadPremiumState(cls):
        return cls.__lobbyContext.getServerSettings().squadPremiumBonus.isEnabled

    @classmethod
    def getPreferredMapsState(cls):
        return cls.__lobbyContext.getServerSettings().isPreferredMapsEnabled()

    @classmethod
    def getDailyQuestsState(cls):
        return cls.__lobbyContext.getServerSettings().getDailyQuestConfig().get('enabled', False)

    @classmethod
    def getCollectorVehicleState(cls):
        return cls.__lobbyContext.getServerSettings().isCollectorVehicleEnabled()

    @classmethod
    def getDogTagsUnlockingState(cls):
        return cls.__lobbyContext.getServerSettings().isDogTagEnabled()

    @classmethod
    def getMapsTrainingState(cls):
        return cls.__lobbyContext.getServerSettings().isMapsTrainingEnabled()


_FEATURES_DATA = {PremiumConfigs.DAILY_BONUS: {_FeatureState.ON: (
                                                 R.strings.system_messages.daily_xp_bonus.switch_on.title(),
                                                 R.strings.system_messages.daily_xp_bonus.switch_on.body(),
                                                 SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                                _FeatureState.OFF: (
                                                  R.strings.system_messages.daily_xp_bonus.switch_off.title(),
                                                  R.strings.system_messages.daily_xp_bonus.switch_off.body(),
                                                  SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                                _FUNCTION: _StateExtractor.getAdditionalBonusState}, 
   PremiumConfigs.PREM_SQUAD: {_FeatureState.ON: (
                                                R.strings.system_messages.squad_bonus.switch_on.title(),
                                                R.strings.system_messages.squad_bonus.switch_on.body(),
                                                SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                               _FeatureState.OFF: (
                                                 R.strings.system_messages.squad_bonus.switch_off.title(),
                                                 R.strings.system_messages.squad_bonus.switch_off.body(),
                                                 SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                               _FUNCTION: _StateExtractor.getSquadPremiumState}, 
   PremiumConfigs.IS_PREFERRED_MAPS_ENABLED: {_FeatureState.ON: (
                                                               R.strings.system_messages.maps_black_list.switch_on.title(),
                                                               R.strings.system_messages.maps_black_list.switch_on.body(),
                                                               SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                                              _FeatureState.OFF: (
                                                                R.strings.system_messages.maps_black_list.switch_off.title(),
                                                                R.strings.system_messages.maps_black_list.switch_off.body(),
                                                                SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                                              _FUNCTION: _StateExtractor.getPreferredMapsState}, 
   PremiumConfigs.PIGGYBANK: {_FeatureState.ON: (
                                               R.strings.system_messages.piggybank.switch_on.title(),
                                               R.strings.system_messages.piggybank.switch_on.body(),
                                               SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                              _FeatureState.OFF: (
                                                R.strings.system_messages.piggybank.switch_off.title(),
                                                R.strings.system_messages.piggybank.switch_off.body(),
                                                SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                              _FUNCTION: _StateExtractor.getPiggyBankState}, 
   PremiumConfigs.PREM_QUESTS: {_FeatureState.ON: (
                                                 R.strings.system_messages.premium_quests.switch_on.title(),
                                                 R.strings.system_messages.premium_quests.switch_on.body(),
                                                 SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                                _FeatureState.OFF: (
                                                  R.strings.system_messages.premium_quests.switch_off.title(),
                                                  R.strings.system_messages.premium_quests.switch_off.body(),
                                                  SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                                _FUNCTION: _StateExtractor.getPremQuestsState}, 
   DAILY_QUESTS_CONFIG: {_FeatureState.ON: (
                                          R.strings.system_messages.daily_quests.switch_on.title(),
                                          R.strings.system_messages.daily_quests.switch_on.body(),
                                          SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                         _FeatureState.OFF: (
                                           R.strings.system_messages.daily_quests.switch_off.title(),
                                           R.strings.system_messages.daily_quests.switch_off.body(),
                                           SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                         _FUNCTION: _StateExtractor.getDailyQuestsState}, 
   CollectorVehicleConsts.CONFIG_NAME: {_FeatureState.ON: (
                                                         R.strings.system_messages.collectorVehicle.switch_on.title(),
                                                         R.strings.system_messages.collectorVehicle.switch_on.body(),
                                                         SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                                        _FeatureState.OFF: (
                                                          R.strings.system_messages.collectorVehicle.switch_off.title(),
                                                          R.strings.system_messages.collectorVehicle.switch_off.body(),
                                                          SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                                        _FUNCTION: _StateExtractor.getCollectorVehicleState}, 
   DOG_TAGS_CONFIG: {_FeatureState.ON: (
                                      R.strings.system_messages.dog_tags.switch_on.title(),
                                      R.strings.system_messages.dog_tags.switch_on.body(),
                                      SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                     _FeatureState.OFF: (
                                       R.strings.system_messages.dog_tags.switch_off.title(),
                                       R.strings.system_messages.dog_tags.switch_off.body(),
                                       SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                     _FUNCTION: _StateExtractor.getDogTagsUnlockingState}, 
   MAPS_TRAINING_ENABLED_KEY: {_FeatureState.ON: (
                                                R.strings.system_messages.maps_training.switch.title(),
                                                R.strings.system_messages.maps_training.switch_on.body(),
                                                SystemMessages.SM_TYPE.FeatureSwitcherOn), 
                               _FeatureState.OFF: (
                                                 R.strings.system_messages.maps_training.switch.title(),
                                                 R.strings.system_messages.maps_training.switch_off.body(),
                                                 SystemMessages.SM_TYPE.FeatureSwitcherOff), 
                               _FUNCTION: _StateExtractor.getMapsTrainingState}}

class _NotificationListener(object):

    def __init__(self):
        super(_NotificationListener, self).__init__()
        self._model = lambda : None

    def start(self, model):
        self._model = weakref.ref(model)
        return True

    def stop(self):
        self._model = lambda : None

    def request(self):
        pass


class _WGNCNotificationListener(_NotificationListener):

    def onProviderEnabled(self):
        pass


class ServiceChannelListener(_NotificationListener):

    @proto_getter(PROTO_TYPE.BW)
    def proto(self):
        return

    def start(self, model):
        result = super(ServiceChannelListener, self).start(model)
        if result:
            channel = g_messengerEvents.serviceChannel
            channel.onServerMessageReceived += self.__onMessageReceived
            channel.onClientMessageReceived += self.__onMessageReceived
            serviceChannel = self.proto.serviceChannel
            messages = serviceChannel.getReadMessages()
            addNotification = model.collection.addItem
            for clientID, (_, formatted, settings) in messages:
                addNotification(self.__makeNotification(clientID, formatted, settings, model))

            serviceChannel.handleUnreadMessages()
        return result

    def stop(self):
        super(ServiceChannelListener, self).stop()
        channel = g_messengerEvents.serviceChannel
        channel.onServerMessageReceived -= self.__onMessageReceived
        channel.onClientMessageReceived -= self.__onMessageReceived

    def __onMessageReceived(self, clientID, formatted, settings):
        model = self._model()
        if model:
            model.addNotification(self.__makeNotification(clientID, formatted, settings, model))

    def __makeNotification(self, clientID, formatted, settings, model):
        messageDecorator = self.__getMessageDecorator(settings.messageType, settings.messageSubtype)
        notification = messageDecorator(clientID, formatted, settings, model)
        return notification

    def __getMessageDecorator(self, messageType, messageSubtype):
        if messageType == SYS_MESSAGE_TYPE.autoMaintenance.index():
            if messageSubtype in (AUTO_MAINTENANCE_RESULT.RENT_IS_OVER, AUTO_MAINTENANCE_RESULT.RENT_IS_ALMOST_OVER):
                return C11nMessageDecorator
        else:
            if messageType == SYS_MESSAGE_TYPE.customizationChanged.index():
                return C11nMessageDecorator
            if messageType == SYS_MESSAGE_TYPE.customizationProgress.index():
                return C11nMessageDecorator
            if messageType == SYS_MESSAGE_TYPE.personalMissionFailed.index():
                return LockButtonMessageDecorator
        return MessageDecorator


class MissingEventsListener(_NotificationListener):
    __notificationMgr = dependency.descriptor(INotificationWindowController)

    def start(self, model):
        result = super(MissingEventsListener, self).start(model)
        self.__notificationMgr.onPostponedQueueUpdated += self.__onQueueUpdated
        return result

    def stop(self):
        super(MissingEventsListener, self).stop()
        self.__notificationMgr.onPostponedQueueUpdated -= self.__onQueueUpdated

    def __onQueueUpdated(self, count, isInBootcamp):
        model = self._model()
        if model is not None:
            model.removeNotification(NOTIFICATION_TYPE.MISSING_EVENTS, MissingEventsDecorator.ENTITY_ID)
            if not isInBootcamp and count > 0:
                model.addNotification(MissingEventsDecorator(count))
        return


class PrbInvitesListener(_NotificationListener, IGlobalListener):

    @prbInvitesProperty
    def prbInvites(self):
        return

    def start(self, model):
        result = super(PrbInvitesListener, self).start(model)
        self.startGlobalListening()
        prbInvites = self.prbInvites
        if result and prbInvites:
            prbInvites.onInvitesListInited += self.__onInviteListInited
            prbInvites.onReceivedInviteListModified += self.__onInviteListModified
            if prbInvites.isInited():
                self.__addInvites()
        return result

    def stop(self):
        super(PrbInvitesListener, self).stop()
        self.stopGlobalListening()
        prbInvites = self.prbInvites
        if prbInvites:
            prbInvites.onInvitesListInited -= self.__onInviteListInited
            prbInvites.onReceivedInviteListModified -= self.__onInviteListModified

    def onPrbEntitySwitched(self):
        self.__updateInvites()

    def onTeamStatesReceived(self, entity, team1State, team2State):
        self.__updateInvites()

    def onUnitFlagsChanged(self, flags, timeLeft):
        self.__updateInvites()

    def onEnqueued(self, queueType, *args):
        self.__updateInvites()

    def onDequeued(self, queueType, *args):
        self.__updateInvites()

    def __onInviteListInited(self):
        if self.prbInvites.getUnreadCount() > 0:
            showInvitationInWindowsBar()
        self.__addInvites()

    def __onInviteListModified(self, added, changed, deleted):
        showInvitationInWindowsBar()
        model = self._model()
        if model is None:
            return
        else:
            for inviteID in added:
                invite = self.prbInvites.getInvite(inviteID)
                if invite:
                    model.addNotification(PrbInviteDecorator(invite))

            for inviteID in deleted:
                model.removeNotification(NOTIFICATION_TYPE.INVITE, inviteID)

            for inviteID in changed:
                invite = self.prbInvites.getInvite(inviteID)
                if invite:
                    model.updateNotification(NOTIFICATION_TYPE.INVITE, inviteID, invite, True)

            return

    def __addInvites(self):
        model = self._model()
        if model is None:
            return
        else:
            model.removeNotificationsByType(NOTIFICATION_TYPE.INVITE)
            invites = self.prbInvites.getReceivedInvites()
            invites = sorted(invites, cmp=lambda invite, other: cmp(invite.createTime, other.createTime))
            for invite in invites:
                model.addNotification(PrbInviteDecorator(invite))

            return

    def __updateInvites(self):
        model = self._model()
        if model:
            invites = self.prbInvites.getReceivedInvites()
            for invite in invites:
                model.updateNotification(NOTIFICATION_TYPE.INVITE, invite.clientID, invite, False)


class FriendshipRqsListener(_NotificationListener):

    @proto_getter(PROTO_TYPE.XMPP)
    def proto(self):
        return

    def start(self, model):
        result = super(FriendshipRqsListener, self).start(model)
        g_messengerEvents.onPluginDisconnected += self.__me_onPluginDisconnected
        messengerEvents = g_messengerEvents.users
        messengerEvents.onFriendshipRequestsAdded += self.__me_onFriendshipRequestsAdded
        messengerEvents.onFriendshipRequestsUpdated += self.__me_onFriendshipRequestsUpdated
        messengerEvents.onUserActionReceived += self.__me_onUserActionReceived
        contacts = self.proto.contacts.getFriendshipRqs()
        for contact in contacts:
            self.__setRequest(contact)

        return result

    def stop(self):
        g_messengerEvents.onPluginDisconnected -= self.__me_onPluginDisconnected
        messengerEvents = g_messengerEvents.users
        messengerEvents.onFriendshipRequestsAdded -= self.__me_onFriendshipRequestsAdded
        messengerEvents.onFriendshipRequestsUpdated -= self.__me_onFriendshipRequestsUpdated
        messengerEvents.onUserActionReceived -= self.__me_onUserActionReceived
        super(FriendshipRqsListener, self).stop()

    def __setRequest(self, contact):
        model = self._model()
        if model:
            if contact.getProtoType() != PROTO_TYPE.XMPP:
                return
            if contact.getItemType() == XMPP_ITEM_TYPE.EMPTY_ITEM:
                return
            contactID = contact.getID()
            if model.hasNotification(NOTIFICATION_TYPE.FRIENDSHIP_RQ, contactID):
                model.updateNotification(NOTIFICATION_TYPE.FRIENDSHIP_RQ, contactID, contact, self.proto.contacts.canApproveFriendship(contact))
            else:
                model.addNotification(FriendshipRequestDecorator(contact))

    def __updateRequest(self, contact):
        model = self._model()
        if model:
            if contact.getProtoType() != PROTO_TYPE.XMPP:
                return
            model.updateNotification(NOTIFICATION_TYPE.FRIENDSHIP_RQ, contact.getID(), contact, False)

    def __updateRequests(self):
        contacts = self.proto.contacts.getFriendshipRqs()
        for contact in contacts:
            self.__updateRequest(contact)

    def __me_onPluginDisconnected(self, protoType):
        if protoType == PROTO_TYPE.XMPP:
            self.__updateRequests()

    def __me_onFriendshipRequestsAdded(self, contacts):
        for contact in contacts:
            self.__setRequest(contact)

    def __me_onFriendshipRequestsUpdated(self, contacts):
        for contact in contacts:
            self.__updateRequest(contact)

    def __me_onUserActionReceived(self, actionID, contact, shadowMode):
        if contact.getProtoType() != PROTO_TYPE.XMPP:
            return
        if actionID in (
         USER_ACTION_ID.SUBSCRIPTION_CHANGED,
         USER_ACTION_ID.IGNORED_ADDED):
            self.__updateRequest(contact)
        elif actionID in (
         USER_ACTION_ID.FRIEND_ADDED,
         USER_ACTION_ID.FRIEND_REMOVED):
            self.__updateRequests()


class _ClanNotificationsCommonListener(_WGNCNotificationListener, ClanListener):

    def __init__(self):
        super(_ClanNotificationsCommonListener, self).__init__()
        self.__startTime = None
        return

    def start(self, model):
        result = super(_ClanNotificationsCommonListener, self).start(model)
        self.startClanListening()
        g_wgncEvents.onProxyDataItemShowByDefault += self._onProxyDataItemShow
        self.__startTime = time_utils.getCurrentTimestamp()
        if not self._canBeShown():
            return
        storedItems = self._getStoredReceivedItems()
        itemsByTypeCount = len(storedItems)
        LOG_DEBUG('Clan WGNC new notifications count with type "%d": %d' % (
         self._getNewReceivedItemType(), itemsByTypeCount))
        if itemsByTypeCount:
            if itemsByTypeCount > 1:
                self._addMultiNotification(storedItems)
            else:
                self._addSingleNotification(storedItems[0])
        return result

    def stop(self):
        self.stopClanListening()
        g_wgncEvents.onProxyDataItemShowByDefault -= self._onProxyDataItemShow
        super(_ClanNotificationsCommonListener, self).stop()

    def onAccountClanProfileChanged(self, profile):
        pass

    def onClanEnableChanged(self, enabled):
        super(_ClanNotificationsCommonListener, self).onClanEnableChanged(enabled)
        model = self._model()
        if model:
            if not self.webCtrl.isEnabled():
                self._removeAllNotifications()
            else:
                self._updateAllNotifications()

    def _onProxyDataItemShow(self, notID, item):
        if not self._canBeShown():
            return True
        else:
            if self._getNewReceivedItemType() == item.getType():
                model = self._model()
                if self.__startTime:
                    if time_utils.getCurrentTimestamp() - self.__startTime < 5:
                        multiNot = self._getMultiNotification()
                        if multiNot:
                            model.updateNotification(multiNot.getType(), multiNot.getID(), multiNot.getEntity() + 1, False)
                        else:
                            self._addSingleNotification(item)
                    else:
                        self.__startTime = None
                        self._addSingleNotification(item)
                else:
                    self._addSingleNotification(item)
                return True
            return False

    def _getStoredReceivedItems(self):
        return self._getNotMarkedItemsByType(self._getNewReceivedItemType())

    def _getNotMarkedItemsByType(self, itemType):
        itemsByType = []
        for notification in g_wgncProvider.getNotMarkedNots():
            proxyDataItem = notification.getProxyItemByType(itemType)
            if proxyDataItem is None:
                continue
            notification.marked = True
            itemsByType.append(proxyDataItem)

        return itemsByType

    def _getNewReceivedItemType(self):
        raise NotImplementedError

    def _addSingleNotification(self, item):
        raise NotImplementedError

    def _addMultiNotification(self, items, count=None):
        raise NotImplementedError

    def _getMultiNotification(self):
        raise NotImplementedError

    def _canBeShown(self):
        return self.webCtrl.isEnabled() and self.webCtrl.getAccountProfile() is not None and self.settingsCore.getSetting('receiveClanInvitesNotifications')

    def _updateAllNotifications(self):
        pass

    def _removeAllNotifications(self):
        pass

    def _removeNotifications(self, notificationList):
        model = self._model()
        for notDecorator in model.collection.getListIterator(notificationList):
            model.removeNotification(notDecorator.getType(), notDecorator.getID())


class _ClanAppsListener(_ClanNotificationsCommonListener, UsersInfoHelper):
    _TYPES_EXPECTED_USERS_NAMES = (
     NOTIFICATION_TYPE.CLAN_APP,
     NOTIFICATION_TYPE.CLAN_INVITE_ACTION)

    def __init__(self):
        super(_ClanAppsListener, self).__init__()
        self.__userNamePendingNotifications = defaultdict(set)

    def stop(self):
        super(_ClanAppsListener, self).stop()
        self.__userNamePendingNotifications = defaultdict(set)

    def onClanAppStateChanged(self, appId, state):
        self.__updateNotificationState(appId, state)

    def onAccountClanProfileChanged(self, profile):
        if not profile.isInClan() or not profile.getMyClanPermissions().canHandleClanInvites():
            model = self._model()
            for notification in model.collection.getListIterator((NOTIFICATION_TYPE.CLAN_APP,
             NOTIFICATION_TYPE.CLAN_APPS)):
                model.removeNotification(notification.getType(), notification.getID())

    def onUserNamesReceived(self, names):
        for userDBID, userName in names.iteritems():
            if userDBID in self.__userNamePendingNotifications:
                model = self._model()
                for appId in self.__userNamePendingNotifications[userDBID]:
                    for nType in self._TYPES_EXPECTED_USERS_NAMES:
                        clanSingleAppDecorator = model.getNotification(nType, appId)
                        if clanSingleAppDecorator:
                            clanSingleAppDecorator.setUserName(userName)
                            model.updateNotification(nType, appId, clanSingleAppDecorator.getEntity(), False)

                self.__userNamePendingNotifications[userDBID] = set()

    def _onProxyDataItemShow(self, notID, item):
        isProcessed = super(_ClanAppsListener, self)._onProxyDataItemShow(notID, item)
        if not isProcessed:
            itemType = item.getType()
            if itemType == WGNC_DATA_PROXY_TYPE.CLAN_INVITE_ACCEPTED:
                self.__addUserNotification(ClanInvitesActionDecorator, (item.getID(), 'inviteAccepted'), item)
                isProcessed = True
            elif itemType == WGNC_DATA_PROXY_TYPE.CLAN_INVITE_DECLINED:
                self.__addUserNotification(ClanInvitesActionDecorator, (item.getID(), 'inviteDeclined'), item)
                isProcessed = True
            elif itemType == WGNC_DATA_PROXY_TYPE.CLAN_APP_ACCEPTED_FOR_MEMBERS:
                self.__updateNotificationState(item.getApplicationID(), CLAN_APPLICATION_STATES.ACCEPTED)
                isProcessed = True
            elif itemType == WGNC_DATA_PROXY_TYPE.CLAN_APP_DECLINED_FOR_MEMBERS:
                self.__updateNotificationState(item.getApplicationID(), CLAN_APPLICATION_STATES.DECLINED)
                isProcessed = True
        return isProcessed

    def _getNewReceivedItemType(self):
        return wgnc_settings.WGNC_DATA_PROXY_TYPE.CLAN_APP

    def _getStoredReceivedItems(self):
        storedClanAPPs = super(_ClanAppsListener, self)._getStoredReceivedItems()
        processedClamAPPs = self._getNotMarkedItemsByType(wgnc_settings.WGNC_DATA_PROXY_TYPE.CLAN_APP_ACCEPTED_FOR_MEMBERS)
        processedClamAPPs.extend(self._getNotMarkedItemsByType(wgnc_settings.WGNC_DATA_PROXY_TYPE.CLAN_APP_DECLINED_FOR_MEMBERS))
        for processedAPP in processedClamAPPs:
            for i in xrange(len(storedClanAPPs) - 1, -1, -1):
                storedAPP = storedClanAPPs[i]
                if processedAPP.getApplicationID() == storedAPP.getApplicationID():
                    del storedClanAPPs[i]

        return storedClanAPPs

    @process
    def _addSingleNotification(self, item):
        ctx = GetClanInfoCtx(item.getAccountID())
        self.__addUserNotification(ClanSingleAppDecorator, (item.getID(), item), item)
        accountResponse = yield self.webCtrl.sendRequest(ctx)
        if accountResponse.isSuccess():
            accountInfo = ctx.getDataObj(accountResponse.data)
            isInCooldown = isInClanEnterCooldown(accountInfo.getClanCooldownTill())
            if isInCooldown:
                model = self._model()
                appId = item.getApplicationID()
                clanSingleAppDecorator = model.getNotification(NOTIFICATION_TYPE.CLAN_APP, appId)
                if clanSingleAppDecorator:
                    clanSingleAppDecorator.setClanEnterCooldown(isInCooldown)
                    model.updateNotification(NOTIFICATION_TYPE.CLAN_APP, appId, clanSingleAppDecorator.getEntity(), False)

    def _addMultiNotification(self, items, count=None):
        count = int(len(items) if items else count)
        self._model().addNotification(ClanAppsDecorator(self.webCtrl.getAccountProfile().getClanDbID(), count))

    def _getMultiNotification(self):
        return self._model().getNotification(NOTIFICATION_TYPE.CLAN_APPS, self.webCtrl.getAccountProfile().getClanDbID())

    def _updateAllNotifications(self):
        model = self._model()
        for notifications in model.collection.getListIterator((NOTIFICATION_TYPE.CLAN_APP,
         NOTIFICATION_TYPE.CLAN_APPS)):
            model.updateNotification(notifications.getType(), notifications.getID(), notifications.getEntity(), False)

    def _removeAllNotifications(self):
        self._removeNotifications((
         NOTIFICATION_TYPE.CLAN_APP,
         NOTIFICATION_TYPE.CLAN_APPS,
         NOTIFICATION_TYPE.CLAN_INVITE_ACTION))

    def _canBeShown(self):
        canBeShown = super(_ClanAppsListener, self)._canBeShown()
        profile = self.webCtrl.getAccountProfile()
        return canBeShown and profile.isInClan() and profile.getMyClanPermissions().canHandleClanInvites()

    def __addUserNotification(self, clazz, args, item):
        userDatabaseID = item.getAccountID()
        appId = item.getID()
        userName = self.getUserName(userDatabaseID)
        if not userName:
            self.__userNamePendingNotifications[userDatabaseID].add(appId)
            self.syncUsersInfo()
            userName = i18n.makeString(CLANS.CLANINVITE_NOTIFICATION_USERNAMEERROR)
        notification = clazz(userName=userName, *args)
        notificationType = notification.getType()
        if notificationType not in self._TYPES_EXPECTED_USERS_NAMES:
            LOG_ERROR(('Unexpected notification type "{}"').format(notificationType))
        else:
            self._model().addNotification(notification)

    def __updateNotificationState(self, appId, state):
        model = self._model()
        clanSingleAppDecorator = model.getNotification(NOTIFICATION_TYPE.CLAN_APP, appId)
        if clanSingleAppDecorator:
            clanSingleAppDecorator.setState(state)
            model.updateNotification(NOTIFICATION_TYPE.CLAN_APP, appId, clanSingleAppDecorator.getEntity(), False)


class _ClanPersonalInvitesListener(_ClanNotificationsCommonListener):
    _INVITES_ENTITY_ID = 1

    def onAccountWebVitalInfoChanged(self, fieldName, value):
        super(_ClanPersonalInvitesListener, self).onAccountWebVitalInfoChanged(fieldName, value)
        if SYNC_KEYS.CLAN_INFO == fieldName:
            profile = self.webCtrl.getAccountProfile()
            if not profile.isInClan():
                self.__updateNotificationsByTypes((NOTIFICATION_TYPE.CLAN_INVITE,))

    def onAccountClanProfileChanged(self, profile):
        if profile.isInClan():
            model = self._model()
            for notDecorator in model.collection.getListIterator((NOTIFICATION_TYPE.CLAN_INVITE,
             NOTIFICATION_TYPE.CLAN_INVITES)):
                model.removeNotification(notDecorator.getType(), notDecorator.getID())

    def onClanInvitesStateChanged(self, inviteIds, state):
        model = self._model()
        for inviteId in inviteIds:
            clanSingleInvDecorator = model.getNotification(NOTIFICATION_TYPE.CLAN_INVITE, inviteId)
            if clanSingleInvDecorator:
                clanSingleInvDecorator.setState(state)
                model.updateNotification(NOTIFICATION_TYPE.CLAN_INVITE, inviteId, clanSingleInvDecorator.getEntity(), False)

    def _onProxyDataItemShow(self, notID, item):
        isProcessed = super(_ClanPersonalInvitesListener, self)._onProxyDataItemShow(notID, item)
        if not isProcessed:
            itemType = item.getType()
            if itemType == WGNC_DATA_PROXY_TYPE.CLAN_APP_DECLINED:
                self._model().addNotification(ClanAppActionDecorator(item.getApplicationId(), 'appDeclined', (
                 item.getClanName(), item.getClanTag())))
                isProcessed = True
            elif itemType == WGNC_DATA_PROXY_TYPE.CLAN_APP_ACCEPTED:
                self._model().addNotification(ClanAppActionDecorator(item.getApplicationId(), 'appAccepted', (
                 item.getClanName(), item.getClanTag())))
                isProcessed = True
        return isProcessed

    def _getNewReceivedItemType(self):
        return wgnc_settings.WGNC_DATA_PROXY_TYPE.CLAN_INVITE

    def _addSingleNotification(self, item):
        self._model().addNotification(ClanSingleInviteDecorator(item.getID(), item))

    def _addMultiNotification(self, items, count=None):
        count = int(len(items) if items else count)
        self._model().addNotification(ClanInvitesDecorator(self.webCtrl.getAccountProfile().getDbID(), count))

    def _getMultiNotification(self):
        return self._model().getNotification(NOTIFICATION_TYPE.CLAN_INVITES, self.webCtrl.getAccountProfile().getDbID())

    def _updateAllNotifications(self):
        self.__updateNotificationsByTypes((NOTIFICATION_TYPE.CLAN_INVITE, NOTIFICATION_TYPE.CLAN_INVITES))

    def __updateNotificationsByTypes(self, notifTypes):
        model = self._model()
        for notDecorator in model.collection.getListIterator(notifTypes):
            model.updateNotification(notDecorator.getType(), notDecorator.getID(), notDecorator.getEntity(), False)

    def _removeAllNotifications(self):
        self._removeNotifications((
         NOTIFICATION_TYPE.CLAN_INVITE,
         NOTIFICATION_TYPE.CLAN_INVITES,
         NOTIFICATION_TYPE.CLAN_APP_ACTION))

    def _canBeShown(self):
        isCtrlrEnabled = super(_ClanPersonalInvitesListener, self)._canBeShown()
        profile = self.webCtrl.getAccountProfile()
        return isCtrlrEnabled and not profile.isInClan()


class _WGNCListener(_WGNCNotificationListener):

    def __init__(self):
        super(_WGNCListener, self).__init__()
        self.__offset = 0

    def start(self, model):
        result = super(_WGNCListener, self).start(model)
        g_wgncEvents.onItemShowByDefault += self.__onItemShowByDefault
        g_wgncEvents.onItemShowByAction += self.__onItemShowByAction
        g_wgncEvents.onItemUpdatedByAction += self.__onItemUpdatedByAction
        addNotification = model.collection.addItem
        for notification in g_wgncProvider.getMarkedNots():
            popUp = notification.getItemByType(wgnc_settings.WGNC_GUI_TYPE.POP_UP)
            if popUp is None:
                continue
            addNotification(WGNCPopUpDecorator(notification.notID, popUp, receivedAt=notification.order))

        self.__offset = 0.1
        return result

    def onProviderEnabled(self):
        self.__offset = 0

    def stop(self):
        g_wgncEvents.onItemShowByDefault -= self.__onItemShowByDefault
        g_wgncEvents.onItemShowByAction -= self.__onItemShowByAction
        g_wgncEvents.onItemUpdatedByAction -= self.__onItemUpdatedByAction
        super(_WGNCListener, self).stop()

    def __onItemShowByDefault(self, notID, item):
        model = self._model()
        if model and item.getType() == wgnc_settings.WGNC_GUI_TYPE.POP_UP:
            model.addNotification(WGNCPopUpDecorator(notID, item, self.__offset))

    def __onItemShowByAction(self, notID, target):
        g_wgncProvider.showNotItemByName(notID, target)

    def __onItemUpdatedByAction(self, notID, item):
        model = self._model()
        if model and item.getType() == wgnc_settings.WGNC_GUI_TYPE.POP_UP:
            model.updateNotification(NOTIFICATION_TYPE.WGNC_POP_UP, notID, item, False)


class _WGNCListenersContainer(_NotificationListener):

    def __init__(self):
        super(_WGNCListenersContainer, self).__init__()
        self.__wgncListener = _WGNCListener()
        self.__clanListeners = (_ClanAppsListener(), _ClanPersonalInvitesListener())

    def start(self, model):
        self.__wgncListener.start(model)
        g_wgncProvider.showNoMarkedNots()
        g_wgncProvider.setEnabled(True)
        for listener in self.__clanListeners:
            listener.start(model)

        self.__wgncListener.onProviderEnabled()
        return super(_WGNCListenersContainer, self).start(model)

    def stop(self):
        self.__wgncListener.stop()
        for listener in self.__clanListeners:
            listener.stop()

        g_wgncProvider.setEnabled(False)
        g_wgncProvider.setNotsAsMarked()
        super(_WGNCListenersContainer, self).stop()


class BattleTutorialListener(_NotificationListener, IGlobalListener):
    _messagesIDs = tutorial_helper.TutorialGlobalStorage(tutorial_helper.TUTORIAL_GLOBAL_VAR.SERVICE_MESSAGES_IDS, [])

    @proto_getter(PROTO_TYPE.BW)
    def proto(self):
        return

    def start(self, model):
        self.startGlobalListening()
        return super(BattleTutorialListener, self).start(model)

    def stop(self):
        super(BattleTutorialListener, self).stop()
        self.stopGlobalListening()

    def onEnqueued(self, queueType, *args):
        self.__updateBattleResultMessage(True)

    def onDequeued(self, queueType, *args):
        self.__updateBattleResultMessage(False)

    def __updateBattleResultMessage(self, locked):
        model = self._model()
        if not model:
            return
        else:
            ids = self._messagesIDs
            if not isinstance(ids, collections.Iterable):
                return
            for messageID in ids:
                _, formatted, settings = self.proto.serviceChannel.getMessage(messageID)
                if formatted and settings:
                    if 'buttonsStates' not in formatted:
                        return
                    submit = formatted['buttonsStates'].get('submit')
                    if submit is None or submit != NOTIFICATION_BUTTON_STATE.HIDDEN:
                        if locked:
                            submit = NOTIFICATION_BUTTON_STATE.VISIBLE
                        else:
                            submit = NOTIFICATION_BUTTON_STATE.VISIBLE | NOTIFICATION_BUTTON_STATE.ENABLED
                        formatted['buttonsStates']['submit'] = submit
                    model.updateNotification(NOTIFICATION_TYPE.MESSAGE, messageID, formatted, False)

            return


class ProgressiveRewardListener(_NotificationListener):
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __bootcampController = dependency.descriptor(IBootcampController)

    def __init__(self):
        super(ProgressiveRewardListener, self).__init__()
        self.__isEnabled = None
        return

    def start(self, model):
        super(ProgressiveRewardListener, self).start(model)
        self.__isEnabled = self.__lobbyContext.getServerSettings().getProgressiveRewardConfig().isEnabled
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingsChange
        g_eventBus.addListener(events.ProgressiveRewardEvent.WIDGET_WAS_SHOWN, self.__widgetWasShown)
        self.__update()
        return True

    def stop(self):
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChange
        g_eventBus.removeListener(events.ProgressiveRewardEvent.WIDGET_WAS_SHOWN, self.__widgetWasShown)
        super(ProgressiveRewardListener, self).stop()

    def __widgetWasShown(self, _):
        model = self._model()
        if model is None:
            return
        else:
            model.removeNotification(NOTIFICATION_TYPE.PROGRESSIVE_REWARD, ProgressiveRewardDecorator.ENTITY_ID)
            if self.__seniorityAwardsIsActive():
                AccountSettings.setCounters(SENIORITY_AWARDS_COUNTER, 1)
            else:
                AccountSettings.setNotifications(PROGRESSIVE_REWARD_VISITED, True)
            return

    def __onServerSettingsChange(self, diff):
        if 'progressive_reward_config' in diff:
            isEnabled = diff['progressive_reward_config'].get('isEnabled', self.__isEnabled)
            if isEnabled != self.__isEnabled:
                priority = NotificationPriorityLevel.MEDIUM
                if isEnabled:
                    SystemMessages.pushMessage(backport.text(R.strings.system_messages.progressiveReward.switch_on()), priority=priority)
                else:
                    SystemMessages.pushMessage(backport.text(R.strings.system_messages.progressiveReward.switch_off()), priority=priority)
                self.__isEnabled = isEnabled
            self.__update()

    def __update(self):
        model = self._model()
        if model is None:
            return
        else:
            model.removeNotificationsByType(NOTIFICATION_TYPE.PROGRESSIVE_REWARD)
            wasVisited = AccountSettings.getNotifications(PROGRESSIVE_REWARD_VISITED)
            if self.__seniorityAwardsIsActive():
                wasVisited = wasVisited and AccountSettings.getCounters(SENIORITY_AWARDS_COUNTER)
            if wasVisited:
                return
            progressiveConfig = self.__lobbyContext.getServerSettings().getProgressiveRewardConfig()
            if not progressiveConfig.isEnabled or self.__bootcampController.isInBootcamp():
                return
            model.addNotification(ProgressiveRewardDecorator())
            return

    def __seniorityAwardsIsActive(self):
        return getSeniorityAwardsBoxesCount() > 0


class SwitcherListener(_NotificationListener):
    slots = ('__currentStates', )
    __lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self):
        super(SwitcherListener, self).__init__()
        self.__currentStates = {}

    def start(self, model):
        super(SwitcherListener, self).start(model)
        self.__fillCurrentStates()
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingsChange
        return True

    def stop(self):
        self.__currentStates = None
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChange
        super(SwitcherListener, self).stop()
        return

    def __onServerSettingsChange(self, diff):
        for feature, data in _FEATURES_DATA.iteritems():
            if feature in diff:
                isEnabled = data[_FUNCTION]()
                self.__addMessage(feature, isEnabled)
                self.__currentStates[feature] = isEnabled

    def __fillCurrentStates(self):
        for featureName, value in _FEATURES_DATA.iteritems():
            self.__currentStates[featureName] = value[_FUNCTION]()

    def __addMessage(self, featureName, newState):
        if self.__currentStates[featureName] != newState:
            msg = _FEATURES_DATA[featureName]
            if newState:
                msgTitle, msgBody, msgType = msg[_FeatureState.ON]
                SystemMessages.pushMessage(type=msgType, text=backport.text(msgBody), messageData={'header': backport.text(msgTitle)})
            else:
                msgTitle, msgBody, msgType = msg[_FeatureState.OFF]
                SystemMessages.pushMessage(type=msgType, text=backport.text(msgBody), messageData={'header': backport.text(msgTitle)})


class TankPremiumListener(_NotificationListener):
    __gameSession = dependency.descriptor(IGameSessionController)
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __itemsCache = dependency.descriptor(IItemsCache)

    def start(self, model):
        super(TankPremiumListener, self).start(model)
        self.__addListeners()
        return True

    def stop(self):
        super(TankPremiumListener, self).stop()
        self.__removeListeners()

    def __addListeners(self):
        self.__gameSession.onPremiumNotify += self.__onTankPremiumActiveChanged
        g_clientUpdateManager.addCallbacks({PiggyBankConstants.PIGGY_BANK_CREDITS: self.__onPiggyBankCreditsChanged})

    def __removeListeners(self):
        self.__gameSession.onPremiumNotify -= self.__onTankPremiumActiveChanged
        g_clientUpdateManager.removeCallback(PiggyBankConstants.PIGGY_BANK_CREDITS, self.__onPiggyBankCreditsChanged)

    def __onPiggyBankCreditsChanged(self, credits_=None):
        config = self.__lobbyContext.getServerSettings().getPiggyBankConfig()
        maxAmount = config.get('creditsThreshold', PiggyBankConstants.MAX_AMOUNT)
        data = self.__itemsCache.items.stats.piggyBank
        if credits_ >= maxAmount:
            timeLeft = time_formatters.getTillTimeByResource(getDeltaTimeHelper(config, data), R.strings.premacc.piggyBankCard.timeLeft)
            SystemMessages.pushMessage(priority=NotificationPriorityLevel.MEDIUM, text=backport.text(R.strings.system_messages.piggyBank.piggyBankFull(), timeValue=timeLeft))

    def __onTankPremiumActiveChanged(self, isPremActive, *_):
        if not isPremActive:
            priority = NotificationPriorityLevel.LOW
            SystemMessages.pushMessage(priority=priority, text=backport.text(R.strings.messenger.serviceChannelMessages.piggyBank.onPause()))


class BattlePassListener(_NotificationListener):
    __slots__ = ('__isStarted', '__isFinished', '__arenaBonusTypesEnabledState', '__arenaBonusTypesHandlers')
    __battlePassController = dependency.descriptor(IBattlePassController)
    __itemsCache = dependency.descriptor(IItemsCache)
    __notificationCtrl = dependency.descriptor(IEventsNotificationsController)

    def __init__(self):
        super(BattlePassListener, self).__init__()
        self.__isStarted = None
        self.__isFinished = None
        self.__arenaBonusTypesEnabledState = None
        self.__arenaBonusTypesHandlers = None
        return

    def start(self, model):
        super(BattlePassListener, self).start(model)
        self.__isStarted = self.__battlePassController.isSeasonStarted()
        self.__isFinished = self.__battlePassController.isSeasonFinished()
        self.__arenaBonusTypesHandlers = {ARENA_BONUS_TYPE.RANKED: self.__pushEnableChangeRanked, 
           ARENA_BONUS_TYPE.BATTLE_ROYALE_SOLO: self.__pushBattleRoyaleEnableChange, 
           ARENA_BONUS_TYPE.EPIC_BATTLE: self.__pushEpicBattleModeChanged}
        self.__battlePassController.onSeasonStateChange += self.__onSeasonStateChange
        self.__battlePassController.onBattlePassSettingsChange += self.__onBattlePassSettingsChange
        self.__notificationCtrl.onEventNotificationsChanged += self.__onEventNotification
        self.__initArenaBonusTypeEnabledStates()
        return True

    def stop(self):
        self.__battlePassController.onSeasonStateChange -= self.__onSeasonStateChange
        self.__battlePassController.onBattlePassSettingsChange -= self.__onBattlePassSettingsChange
        self.__notificationCtrl.onEventNotificationsChanged -= self.__onEventNotification
        self.__arenaBonusTypesHandlers = None
        super(BattlePassListener, self).stop()
        return

    def __onEventNotification(self, added, removed=()):
        if not self.__battlePassController.isActive():
            return
        for eventNotification in added:
            msgType = eventNotification.eventType
            if msgType != SERVER_CMD_BP_GAMEMODE_ENABBLED:
                continue
            arenaBonusType = eventNotification.data
            header = backport.text(R.strings.system_messages.battlePass.gameModeEnabled.header(), seasonNum=self.__battlePassController.getSeasonNum())
            textRes = R.strings.system_messages.battlePass.gameModeEnabled.body.num(arenaBonusType)
            if not textRes.exists():
                _logger.warning('There is no text for given arenaBonusType: %d', arenaBonusType)
                return
            text = backport.text(textRes())
            SystemMessages.pushMessage(text=text, type=SystemMessages.SM_TYPE.BattlePassGameModeEnabled, messageData={'header': header})

    def __onBattlePassSettingsChange(self, newMode, oldMode):
        self.__checkAndNotify(oldMode, newMode)
        if self.__battlePassController.isEnabled() and newMode == oldMode:
            self.__checkAndNotifyOtherBattleTypes()

    def __onSeasonStateChange(self):
        self.__checkAndNotify()

    def __checkAndNotifyOtherBattleTypes(self):
        supportedTypes = self.__battlePassController.getSupportedArenaBonusTypes()
        for arenaBonusType in supportedTypes:
            oldValue = self.__arenaBonusTypesEnabledState.get(arenaBonusType, False)
            newValue = self.__battlePassController.isGameModeEnabled(arenaBonusType)
            self.__arenaBonusTypesEnabledState[arenaBonusType] = newValue
            if oldValue != newValue:
                self.__pushEnableChangedForArenaBonusType(arenaBonusType, newValue)

    def __checkAndNotify(self, oldMode=None, newMode=None):
        isStarted = self.__battlePassController.isSeasonStarted()
        isFinished = self.__battlePassController.isSeasonFinished()
        isModeChanged = oldMode is not None and newMode is not None and oldMode != newMode
        if self.__isStarted != isStarted and isStarted:
            self.__pushStarted()
        elif self.__isFinished != isFinished and isFinished or isModeChanged and newMode == 'disabled':
            self.__pushFinished()
        if isModeChanged:
            if newMode == 'paused':
                self.__pushPause()
            elif newMode == 'enabled' and oldMode == 'paused':
                self.__pushEnabled()
        self.__isStarted = isStarted
        self.__isFinished = isFinished
        return

    def __pushPause(self):
        SystemMessages.pushMessage(text=backport.text(R.strings.system_messages.battlePass.switch_pause.body()), type=SystemMessages.SM_TYPE.ErrorSimple, priority=NotificationPriorityLevel.HIGH)

    def __pushFinished(self):
        styleCD, styleLevel = getStyleInfoForChapter(self.__battlePassController.getCurrentChapter())
        style = self.__itemsCache.items.getItemByCD(styleCD) if styleCD is not None else None
        if style is not None and style.getMaxProgressionLevel() != styleLevel:
            text = backport.text(R.strings.system_messages.battlePass.switch_disable.body.incompleteStyle(), styleName=style.userName)
        else:
            text = backport.text(R.strings.system_messages.battlePass.switch_disable.body())
        SystemMessages.pushMessage(text=text, priority=NotificationPriorityLevel.HIGH, type=SystemMessages.SM_TYPE.BattlePassInfo, messageData={'header': backport.text(R.strings.system_messages.battlePass.switch_disable.title(), seasonNum=self.__battlePassController.getSeasonNum())})
        return

    def __pushStarted(self):
        SystemMessages.pushMessage(text=backport.text(R.strings.system_messages.battlePass.switch_started.body()), priority=NotificationPriorityLevel.HIGH, type=SystemMessages.SM_TYPE.BattlePassInfo, messageData={'header': backport.text(R.strings.system_messages.battlePass.switch_started.title(), seasonNum=self.__battlePassController.getSeasonNum())})

    def __pushEnabled(self):
        expiryTime = self.__battlePassController.getSeasonFinishTime()
        SystemMessages.pushMessage(text=backport.text(R.strings.system_messages.battlePass.switch_enabled.body(), expiryTime=text_styles.titleFont(TimeFormatter.getLongDatetimeFormat(expiryTime))), priority=NotificationPriorityLevel.HIGH, type=SystemMessages.SM_TYPE.Warning)

    def __pushBattleRoyaleEnableChange(self, isEnabled):
        if not isEnabled:
            SystemMessages.pushMessage(text=backport.text(R.strings.system_messages.battlePass.switch_disable.battle_royale.body()), type=SystemMessages.SM_TYPE.Warning)

    def __pushEnableChangedForArenaBonusType(self, arenaBonusType, newValue):
        if arenaBonusType in self.__arenaBonusTypesHandlers:
            self.__arenaBonusTypesHandlers[arenaBonusType](newValue)

    def __pushEnableChangeRanked(self, isEnabled):
        if isEnabled:
            msg = backport.text(R.strings.system_messages.battlePass.switch_enabled.ranked.body())
            msgType = SystemMessages.SM_TYPE.Warning
        else:
            msg = backport.text(R.strings.system_messages.battlePass.switch_disable.ranked.body())
            msgType = SystemMessages.SM_TYPE.ErrorSimple
        SystemMessages.pushMessage(text=msg, type=msgType)

    def __initArenaBonusTypeEnabledStates(self):
        self.__arenaBonusTypesEnabledState = {}
        supportedTypes = self.__battlePassController.getSupportedArenaBonusTypes()
        for arenaBonusType in supportedTypes:
            self.__arenaBonusTypesEnabledState[arenaBonusType] = self.__battlePassController.isGameModeEnabled(arenaBonusType)

    @staticmethod
    def __pushEpicBattleModeChanged(isEnabled):
        if isEnabled:
            msg = backport.text(R.strings.system_messages.battlePass.switch_enabled.epicBattle.body())
            msgType = SystemMessages.SM_TYPE.Warning
        else:
            msg = backport.text(R.strings.system_messages.battlePass.switch_disable.epicBattle.body())
            msgType = SystemMessages.SM_TYPE.ErrorSimple
        SystemMessages.pushMessage(text=msg, type=msgType)


class UpgradeTrophyDeviceListener(_NotificationListener):
    __slots__ = ('__enabled', )
    __lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self):
        super(UpgradeTrophyDeviceListener, self).__init__()
        self.__enabled = None
        return

    def start(self, model):
        super(UpgradeTrophyDeviceListener, self).start(model)
        self.__enabled = self.__lobbyContext.getServerSettings().isTrophyDevicesEnabled()
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingsChange
        return True

    def stop(self):
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChange
        super(UpgradeTrophyDeviceListener, self).stop()

    def __onServerSettingsChange(self, diff):
        if 'isTrophyDevicesEnabled' in diff and self.__enabled != diff['isTrophyDevicesEnabled']:
            self.__enabled = diff['isTrophyDevicesEnabled']
            if self.__enabled:
                SystemMessages.pushMessage(text=backport.text(R.strings.system_messages.upgradeTrophyDevice.switch_on.body()), priority=NotificationPriorityLevel.MEDIUM)
            else:
                SystemMessages.pushMessage(text=backport.text(R.strings.system_messages.upgradeTrophyDevice.switch_off.body()), type=SystemMessages.SM_TYPE.ErrorSimple, priority=NotificationPriorityLevel.MEDIUM)


class ChoosingDeviceslListener(_NotificationListener):

    def start(self, model):
        result = super(ChoosingDeviceslListener, self).start(model)
        if result:
            g_eventBus.addListener(events.ChoosingDevicesEvent.DEVICE_ADDED, self.__onDeviceAdded)
            g_eventBus.addListener(events.ChoosingDevicesEvent.DEVICE_REMOVED, self.__onDeviceRemoved)
        return result

    def stop(self):
        super(ChoosingDeviceslListener, self).stop()
        g_eventBus.removeListener(events.ChoosingDevicesEvent.DEVICE_ADDED, self.__onDeviceAdded)
        g_eventBus.removeListener(events.ChoosingDevicesEvent.DEVICE_REMOVED, self.__onDeviceRemoved)

    def __onDeviceAdded(self, event):
        model = self._model()
        newNotification = event.ctx.get('notifacation')
        if newNotification is None:
            return
        else:
            if model:
                prevNotifacation = model.getNotification(NOTIFICATION_TYPE.CHOOSING_DEVICES, newNotification.getID())
                if prevNotifacation is None:
                    model.addNotification(newNotification)
                else:
                    savedData = newNotification.getSavedData()
                    prevSavedData = prevNotifacation.getSavedData()
                    if prevSavedData.get('count') != savedData.get('count'):
                        model.updateNotification(NOTIFICATION_TYPE.CHOOSING_DEVICES, newNotification.getID(), newNotification.getEntity(), False)
            return

    def __onDeviceRemoved(self, event):
        entityID = event.ctx.get('entityID')
        model = self._model()
        if model:
            model.removeNotification(NOTIFICATION_TYPE.CHOOSING_DEVICES, entityID)


class RecruitReminderlListener(_NotificationListener):
    __loginManager = dependency.descriptor(ILoginManager)
    __bootCampController = dependency.descriptor(IBootcampController)
    __eventsCache = dependency.descriptor(IEventsCache)
    MSG_ID = 0
    _INCREASE_LIMIT_LOGIN = 5

    def __init__(self):
        super(RecruitReminderlListener, self).__init__()
        self._isFirstShow = True

    def start(self, model):
        result = super(RecruitReminderlListener, self).start(model)
        if result:
            g_clientUpdateManager.addCallbacks({'tokens': self.__tryNotify})
            self.__eventsCache.onProgressUpdated += self.__tryNotify
            self.__tryNotify(None)
        return result

    def stop(self):
        super(RecruitReminderlListener, self).stop()
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.__eventsCache.onProgressUpdated -= self.__tryNotify

    def __tryNotify(self, _):
        if self.__bootCampController.isInBootcamp():
            return
        recruits = getAllRecruitsInfo(sortByExpireTime=True)
        recruitsCount = len(recruits)
        if recruitsCount <= 0:
            self.__onRecruitRemoved()
        else:
            time = first(recruits).getExpiryTime()
            rMessage = R.strings.messenger.serviceChannelMessages
            if time:
                message = rMessage.recruitReminder.text()
            else:
                message = rMessage.recruitReminderTermless.text()
            savedData = {'count': recruitsCount}
            msgPrLevel = NotificationPriorityLevel.LOW
            lc = self.__loginManager.getPreference('loginCount')
            if lc == self._INCREASE_LIMIT_LOGIN:
                msgPrLevel = NotificationPriorityLevel.MEDIUM
            notification = RecruitReminderMessageDecorator(self.MSG_ID, backport.text(message, count=recruitsCount, date=time), savedData, msgPrLevel)
            self.__onRecruitAdded(notification)

    def __onRecruitAdded(self, newNotification):
        model = self._model()
        if model:
            prevNotifacation = model.getNotification(NOTIFICATION_TYPE.RECRUIT_REMINDER, newNotification.getID())
            if prevNotifacation is None:
                model.addNotification(newNotification)
            else:
                savedData = newNotification.getSavedData()
                prevSavedData = prevNotifacation.getSavedData()
                if prevSavedData.get('count') != savedData.get('count'):
                    model.updateNotification(NOTIFICATION_TYPE.RECRUIT_REMINDER, newNotification.getID(), newNotification.getEntity(), False)
        return

    def __onRecruitRemoved(self):
        model = self._model()
        if model:
            model.removeNotification(NOTIFICATION_TYPE.RECRUIT_REMINDER, self.MSG_ID)


class EmailConfirmationReminderListener(_NotificationListener):
    __bootCampController = dependency.descriptor(IBootcampController)
    __wgnpCtrl = dependency.descriptor(IWGNPRequestController)
    MSG_ID = 0

    def start(self, model):
        result = super(EmailConfirmationReminderListener, self).start(model)
        if result:
            g_playerEvents.onBattleResultsReceived += self.__tryNotify
            self.__wgnpCtrl.onEmailConfirmed += self.__removeNotify
            self.__wgnpCtrl.onEmailAddNeeded += self.__removeNotify
            self.__tryNotify()
        return result

    def stop(self):
        super(EmailConfirmationReminderListener, self).stop()
        g_playerEvents.onBattleResultsReceived -= self.__tryNotify
        self.__wgnpCtrl.onEmailConfirmed -= self.__removeNotify
        self.__wgnpCtrl.onEmailAddNeeded -= self.__removeNotify

    @async
    def __tryNotify(self):
        emailConfirmationRequired = yield await(isEmailConfirmationRequired())
        isInBootcamp = self.__bootCampController.isInBootcamp()
        if emailConfirmationRequired and not isInBootcamp:
            model = self._model()
            if model is not None:
                message = R.strings.messenger.serviceChannelMessages.emailConfirmationReminder.text()
                notification = EmailConfirmationReminderMessageDecorator(self.MSG_ID, backport.text(message))
                prevNotifacation = model.getNotification(NOTIFICATION_TYPE.EMAIL_CONFIRMATION_REMINDER, notification.getID())
                if prevNotifacation is None:
                    model.addNotification(notification)
                else:
                    model.updateNotification(NOTIFICATION_TYPE.EMAIL_CONFIRMATION_REMINDER, notification.getID(), notification.getEntity(), False)
        return

    def __removeNotify(self):
        model = self._model()
        if model is not None:
            model.removeNotification(NOTIFICATION_TYPE.EMAIL_CONFIRMATION_REMINDER, self.MSG_ID)
        return


class VehiclePostProgressionUnlockListener(_NotificationListener):
    __itemsCache = dependency.descriptor(IItemsCache)

    def start(self, model):
        super(VehiclePostProgressionUnlockListener, self).start(model)
        g_playerEvents.onVehicleBecomeElite += self.__onVehicleBecomeElite
        return True

    def stop(self):
        g_playerEvents.onVehicleBecomeElite -= self.__onVehicleBecomeElite
        super(VehiclePostProgressionUnlockListener, self).stop()

    def __onVehicleBecomeElite(self, *vehicleIntCDs):
        msgKey = R.strings.system_messages.vehiclePostProgression.vehiclesUnlockPostProgression
        for intCD in vehicleIntCDs:
            vehicle = self.__itemsCache.items.getItemByCD(intCD)
            if vehicle is not None and vehicle.postProgressionAvailability(unlockOnly=True):
                SystemMessages.pushMessage(text=backport.text(msgKey.single.body(), vehicle=vehicle.userName), type=SM_TYPE.InformationHeader, priority=NotificationPriorityLevel.HIGH, messageData={'header': backport.text(msgKey.title())})

        return


class NotificationsListeners(_NotificationListener):

    def __init__(self):
        super(NotificationsListeners, self).__init__()
        self.__listeners = (
         ServiceChannelListener(),
         MissingEventsListener(),
         PrbInvitesListener(),
         FriendshipRqsListener(),
         _WGNCListenersContainer(),
         BattleTutorialListener(),
         ProgressiveRewardListener(),
         SwitcherListener(),
         TankPremiumListener(),
         BattlePassListener(),
         UpgradeTrophyDeviceListener(),
         ChoosingDeviceslListener(),
         RecruitReminderlListener(),
         EmailConfirmationReminderListener(),
         VehiclePostProgressionUnlockListener())

    def start(self, model):
        for listener in self.__listeners:
            listener.start(model)

    def stop(self):
        for listener in self.__listeners:
            listener.stop()