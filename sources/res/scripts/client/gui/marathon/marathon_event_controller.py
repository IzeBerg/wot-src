import Event
from frameworks.wulf import WindowLayer
from gui.Scaleform.Waiting import Waiting
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.marathon.marathon_event import MarathonEvent
from gui.marathon.marathon_resource_manager import MarathonResourceManager
from gui.app_loader.decorators import sf_lobby
from gui.shared.utils.scheduled_notifications import Notifiable, PeriodicNotifier
from helpers import dependency, isPlayerAccount
from skeletons.gui.game_control import IMarathonEventsController
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from skeletons.gui.shared.utils import IHangarSpace
_events = []

def marathonCreator(event=MarathonEvent, resourceManager=MarathonResourceManager):

    def wrapper(decoratedClass):
        _events.append(event(resourceManager, decoratedClass))
        return decoratedClass

    return wrapper


def getMarathons():
    return _events


class MarathonEventsController(IMarathonEventsController, Notifiable):
    _eventsCache = dependency.descriptor(IEventsCache)
    _itemsCache = dependency.descriptor(IItemsCache)
    _hangarSpace = dependency.descriptor(IHangarSpace)

    def __init__(self):
        super(MarathonEventsController, self).__init__()
        self.__isLobbyInited = False
        self.__hangarViewLoaded = False
        self.__eventManager = Event.EventManager()
        self.onFlagUpdateNotify = Event.Event(self.__eventManager)
        self.onMarathonDataChanged = Event.Event(self.__eventManager)
        self.onVehicleReceived = Event.Event()
        self.__marathons = _events

    @sf_lobby
    def app(self):
        pass

    def addMarathon(self, marathonEvent):
        self.__marathons.append(marathonEvent)

    def delMarathon(self, prefix):
        self.__marathons.remove(self.__findByPrefix(prefix))

    def getMarathon(self, prefix):
        return self.__findByPrefix(prefix)

    def getMarathons(self):
        return self.__marathons

    def getPrimaryMarathon(self):
        if self.__marathons:
            return self.__marathons[0]
        else:
            return

    def getFirstEnabledMarathon(self):
        for marathon in self.__marathons:
            if marathon.isEnabled():
                return marathon

        return

    def getPrefix(self, eventID):
        for marathon in self.__marathons:
            if eventID.startswith(marathon.prefix):
                return marathon.prefix

        return

    def getVisibleInPostBattleQuests(self):
        result = {}
        for marathon in self.__marathons:
            if marathon.doesShowInPostBattle():
                result.update(marathon.getMarathonQuests())

        return result

    def getQuestsData(self, prefix=None, postfix=None):
        if self.isAnyActive():
            return self.getPrimaryMarathon().getQuestsData(prefix, postfix)
        return {}

    def getTokensData(self, prefix=None, postfix=None):
        if self.isAnyActive():
            return self.getPrimaryMarathon().getTokensData(prefix, postfix)
        return {}

    def isAnyActive(self):
        return any(marathon.isAvailable() for marathon in self.__marathons)

    def doesShowAnyMissionsTab(self):
        return any(marathon.isEnabled() for marathon in self.__marathons)

    def fini(self):
        self.__stop()
        super(MarathonEventsController, self).fini()

    def onDisconnected(self):
        super(MarathonEventsController, self).onDisconnected()
        self.__stop()

    def onAvatarBecomePlayer(self):
        super(MarathonEventsController, self).onAvatarBecomePlayer()
        self.__stop()

    def onLobbyInited(self, event):
        if not isPlayerAccount():
            return
        self.__isLobbyInited = True

    def onLobbyStarted(self, ctx):
        super(MarathonEventsController, self).onLobbyStarted(ctx)
        self._eventsCache.onSyncCompleted += self.__onSyncCompleted
        self._eventsCache.onProgressUpdated += self.__onSyncCompleted
        self._hangarSpace.onVehicleChanged += self.__tryShowScreens
        self._hangarSpace.onHeroTankReady += self.__tryShowScreens
        if self.app and self.app.loaderManager:
            self.app.loaderManager.onViewLoaded += self.__onViewLoaded
        self.__onSyncCompleted()

    def __tryShowScreens(self):
        if self.__hangarViewLoaded and not Waiting.isVisible():
            for marathon in self.__marathons:
                marathon.showRewardScreen()
                marathon.tryShowIntroScreen()

    def __onViewLoaded(self, pyView, _):
        if self.__isLobbyInited:
            if pyView.alias == VIEW_ALIAS.LOBBY_HANGAR:
                self.__hangarViewLoaded = True
                self.__tryShowScreens()
            elif pyView.layer == WindowLayer.SUB_VIEW:
                self.__hangarViewLoaded = False

    def __onSyncCompleted(self, *args):
        self.__checkEvents()
        self.__tryShowScreens()
        self.__reloadNotification()

    def __checkEvents(self):
        for marathon in self.__marathons:
            marathon.updateQuestsData()
            marathon.setState()
            self.onMarathonDataChanged(marathon.prefix)

    def __updateFlagState(self):
        self.__checkEvents()
        self.__tryShowScreens()
        self.onFlagUpdateNotify()

    def __getClosestStatusUpdateTime(self):
        timeList = []
        for marathon in self.__marathons:
            time = marathon.getClosestStatusUpdateTime()
            if time != 0:
                timeList.append(time)

        if timeList:
            return min(timeList)
        return 0

    def __reloadNotification(self):
        self.clearNotification()
        timePeriod = self.__getClosestStatusUpdateTime()
        if timePeriod:
            self.addNotificator(PeriodicNotifier(self.__getClosestStatusUpdateTime, self.__updateFlagState))
            self.startNotification()

    def __stop(self):
        self.clearNotification()
        self._eventsCache.onSyncCompleted -= self.__onSyncCompleted
        self._eventsCache.onProgressUpdated -= self.__onSyncCompleted
        if self.app and self.app.loaderManager:
            self.app.loaderManager.onViewLoaded -= self.__onViewLoaded
        self._hangarSpace.onVehicleChanged -= self.__tryShowScreens
        self._hangarSpace.onHeroTankReady -= self.__tryShowScreens
        self.__isLobbyInited = False

    def __findByPrefix(self, prefix):
        for marathon in self.__marathons:
            if marathon.prefix == prefix:
                return marathon

        return

    def handleOpenVideoContent(self, prefix, url):
        if self.__hangarViewLoaded:
            for marathon in self.__marathons:
                if marathon.prefix == prefix:
                    marathon.showVideoContentScreen(url=url)