from collections import namedtuple
from skeletons.gui.game_control import IFunRandomController
from gui.impl.gen import R
_FunRandomConfig = namedtuple('_FunRandomConfig', ('isEnabled', 'subModes', 'metaProgression'))
_FunRandomProgressConfig = namedtuple('_FunRandomProgressConfig', ('isEnabled', 'progressions'))
_FunRandomStatus = namedtuple('_FunRandomStatus', ('state', 'rightBorder', 'primeDelta'))
_FUN_PROGRESS_CONFIG_STUB = _FunRandomProgressConfig(isEnabled=False, progressions=())
_FUN_CONFIG_STUB = _FunRandomConfig(isEnabled=False, subModes={}, metaProgression=_FUN_PROGRESS_CONFIG_STUB)
_FUN_STATUS_STUB = _FunRandomStatus(state=0, rightBorder=0, primeDelta=0)

class _FunNotifications(IFunRandomController.IFunNotifications):

    def isNotificationsAllowed(self):
        return False

    def isNotificationsEnabled(self):
        return False

    def addToQueue(self, notification):
        pass

    def markSeenAsFrozen(self, subModesIDs):
        pass

    def pushNotification(self, notification):
        pass

    def startNotificationPushing(self):
        pass

    def stopNotificationPushing(self):
        pass

    def updateSettings(self, settings):
        pass


class _FunProgressions(IFunRandomController.IFunProgressions):

    def isProgressionExecutor(self, questID):
        return False

    def getActiveProgression(self):
        return

    def getProgressionTimer(self):
        return 0

    def getSettings(self):
        return _FUN_PROGRESS_CONFIG_STUB

    def startProgressListening(self):
        pass

    def stopProgressListening(self):
        pass

    def updateSettings(self, progressionSettings):
        pass


class _FunSubscription(IFunRandomController.IFunSubscription):

    def addListener(self, eventType, handler, scope=None):
        pass

    def removeListener(self, eventType, handler, scope=None):
        pass

    def handleEvent(self, event, scope=None):
        pass

    def addSubModesWatcher(self, method, desiredOnly=False, withTicks=False):
        pass

    def removeSubModesWatcher(self, method, desiredOnly=False, withTicks=False):
        pass

    def resume(self):
        pass

    def suspend(self):
        pass


class _FunSubModesHolder(IFunRandomController.IFunSubModesHolder):

    def getBattleSubMode(self, arenaVisitor=None):
        return

    def getBattleSubModeID(self, arenaVisitor=None):
        return 0

    def getDesiredSubMode(self):
        return

    def getDesiredSubModeID(self):
        return 0

    def getSubMode(self, subModeID):
        return

    def getSubModes(self, subModesIDs=None, isOrdered=False):
        return []

    def getSubModesIDs(self):
        return []

    def setDesiredSubModeID(self, subModeID, trustedSource=False):
        pass

    def startNotification(self):
        pass

    def stopNotification(self):
        pass

    def updateSettings(self, prevSettings, newSettings):
        pass


class _FunSubModesInfo(IFunRandomController.IFunSubModesInfo):

    def isAvailable(self):
        return False

    def isEntryPointAvailable(self):
        return False

    def getLeftTimeToPrimeTimesEnd(self, now=None, subModes=None):
        return 0

    def getPrimeTimesForDay(self, selectedTime, groupIdentical=False):
        return {}

    def getSubModesStatus(self, subModesIDs=None):
        return _FUN_STATUS_STUB


class FunRandomController(IFunRandomController):

    def __init__(self):
        super(FunRandomController, self).__init__()
        self.__progressions = _FunProgressions()
        self.__notifications = _FunNotifications()
        self.__subscription = _FunSubscription()
        self.__subModesHolder = _FunSubModesHolder()
        self.__subModesInfo = _FunSubModesInfo()

    def fini(self):
        self.__subModesInfo.fini()
        self.__subModesHolder.fini()
        self.__progressions.fini()
        self.__subscription.fini()
        self.__notifications.fini()
        super(FunRandomController, self).fini()

    @property
    def notifications(self):
        return self.__notifications

    @property
    def progressions(self):
        return self.__progressions

    @property
    def subscription(self):
        return self.__subscription

    @property
    def subModesHolder(self):
        return self.__subModesHolder

    @property
    def subModesInfo(self):
        return self.__subModesInfo

    def isEnabled(self):
        return False

    def isFunRandomPrbActive(self):
        return False

    def getAssetsPointer(self):
        return 'undefined'

    def getIconsResRoot(self):
        if R.images.dyn('fun_random'):
            return R.images.fun_random.gui.maps.icons.feature.asset_packs.modes.undefined
        return R.invalid

    def getLocalsResRoot(self):
        if R.strings.dyn('fun_random'):
            return R.strings.fun_random.modes.undefined
        return R.invalid

    def hasHangarHeaderEntry(self):
        return False

    def getSettings(self):
        return _FUN_CONFIG_STUB

    def setDesiredSubModeID(self, subModeID, trustedSource=False):
        pass

    def setSubModesHolder(self, subModesHolder):
        self.__subModesHolder = subModesHolder

    def selectFunRandomBattle(self, desiredSubModeID, callback=None):
        pass