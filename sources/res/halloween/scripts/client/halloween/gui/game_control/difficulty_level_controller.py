from collections import namedtuple
from Event import Event, EventManager
from gui.ClientUpdateManager import g_clientUpdateManager
from halloween.gui import halloween_account_settings
from halloween.gui.halloween_gui_constants import DifficultyLevel, QUEUE_TYPE_TO_DIFFICULTY_LEVEL
from halloween.gui.halloween_account_settings import AccountSettingsKeys
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from halloween_common.halloween_constants import QUEUE_TYPE, DifficultyLevelToken, TOKEN_DIFFICULTY_LEVEL_TO_QUEUE_TYPE
from helpers import dependency
from shared_utils import findFirst
from skeletons.gui.shared import IItemsCache
_Level = namedtuple('_Level', ('queueType', 'level', 'isUnlock'))

class DifficultyLevelController(IDifficultyLevelController):
    _itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        super(DifficultyLevelController, self).__init__()
        self._em = EventManager()
        self.onChangeDifficultyLevelStatus = Event(self._em)
        self.onChangeDifficultyLevel = Event(self._em)
        self.selectedLevel = DifficultyLevel.EASY
        self.items = {}

    def init(self):
        super(DifficultyLevelController, self).init()
        g_clientUpdateManager.addCallbacks({'tokens': self._onSyncTokensCompleted})

    def fini(self):
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.items = {}
        self._em.clear()
        super(DifficultyLevelController, self).fini()

    def onAccountBecomePlayer(self):
        self.selectedLevel = DifficultyLevel(halloween_account_settings.getSettings(AccountSettingsKeys.SELECTED_LEVEL))

    def getLevelsInfo(self):
        return sorted(self.items.itervalues(), key=lambda item: item.level)

    def onLobbyInited(self, event):
        tokens = self._itemsCache.items.tokens.getTokens()
        for difficultyLevelToken in DifficultyLevelToken.ALL_LEVELS:
            queueType, level = self._getLevelInfo(difficultyLevelToken)
            isUnlock = difficultyLevelToken in DifficultyLevelToken.ALWAYS_AVIABLED or difficultyLevelToken in tokens
            self.items[difficultyLevelToken] = _Level(queueType, level, isUnlock)
            if isUnlock:
                self.onChangeDifficultyLevelStatus(self.items[difficultyLevelToken])

    def selectLevel(self, level):
        if level == self.selectedLevel:
            return
        self.selectedLevel = level
        halloween_account_settings.setSettings(AccountSettingsKeys.SELECTED_LEVEL, level.value)
        self.onChangeDifficultyLevel(level)

    def getSelectedLevel(self):
        return self.selectedLevel

    def getCurrentQueueType(self):
        difficultyLevel = findFirst(lambda item: item.level == self.selectedLevel, self.items.itervalues())
        if difficultyLevel:
            return difficultyLevel.queueType
        return QUEUE_TYPE.HALLOWEEN

    def _onSyncTokensCompleted(self, diff):
        for difficultyLevelToken in DifficultyLevelToken.ALL_LEVELS:
            if difficultyLevelToken not in diff:
                continue
            queueType, level = self._getLevelInfo(difficultyLevelToken)
            isUnlock = bool(diff[difficultyLevelToken])
            self.items[difficultyLevelToken] = _Level(queueType, level, isUnlock)
            self.onChangeDifficultyLevelStatus(self.items[difficultyLevelToken])

    def _getLevelInfo(self, token):
        queueType = TOKEN_DIFFICULTY_LEVEL_TO_QUEUE_TYPE[token]
        level = QUEUE_TYPE_TO_DIFFICULTY_LEVEL[queueType]
        return (queueType, level)