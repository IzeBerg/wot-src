from enum import IntEnum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from armory_yard.gui.impl.gen.view_models.views.lobby.feature.armory_yard_chapter_model import ArmoryYardChapterModel
from armory_yard.gui.impl.gen.view_models.views.lobby.feature.armory_yard_level_model import ArmoryYardLevelModel
from armory_yard.gui.impl.gen.view_models.views.lobby.feature.armory_yard_quest_model import ArmoryYardQuestModel
from armory_yard.gui.impl.gen.view_models.views.lobby.feature.armory_yard_rewards_vehicle_model import ArmoryYardRewardsVehicleModel

class AnimationStatus(IntEnum):
    DISABLED = 0
    ACTIVE = 1


class RewardStatus(IntEnum):
    EMPTYREWARDS = 0
    READYREWARDS = 1
    ANIMATEDREWARDS = 2


class TabId(IntEnum):
    PROGRESS = 0
    QUESTS = 1


class EscSource(IntEnum):
    KEYBOARD = 0
    MOUSE = 1


class SimpleTooltipStates(IntEnum):
    TAB = 0
    CHAPTER = 1


class ArmoryYardMainViewModel(ViewModel):
    __slots__ = ('onMoveSpace', 'onStartMoving', 'onTabChange', 'onClose', 'onPlayAnimation',
                 'onSkipAnimation', 'onAboutEvent', 'onCollectReward', 'onBuyTokens',
                 'onShowVehiclePreview')
    TOOLTIP_ID_ARG = 'tooltipId'
    FINAL_REWARD_TOOLTIP_TYPE = 'finalReward'

    def __init__(self, properties=14, commands=10):
        super(ArmoryYardMainViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def finalReward(self):
        return self._getViewModel(0)

    @staticmethod
    def getFinalRewardType():
        return ArmoryYardRewardsVehicleModel

    def getTabId(self):
        return TabId(self._getNumber(1))

    def setTabId(self, value):
        self._setNumber(1, value.value)

    def getCurrentLevel(self):
        return self._getNumber(2)

    def setCurrentLevel(self, value):
        self._setNumber(2, value)

    def getViewedLevel(self):
        return self._getNumber(3)

    def setViewedLevel(self, value):
        self._setNumber(3, value)

    def getRewardStatus(self):
        return RewardStatus(self._getNumber(4))

    def setRewardStatus(self, value):
        self._setNumber(4, value.value)

    def getChapters(self):
        return self._getArray(5)

    def setChapters(self, value):
        self._setArray(5, value)

    @staticmethod
    def getChaptersType():
        return ArmoryYardChapterModel

    def getLevels(self):
        return self._getArray(6)

    def setLevels(self, value):
        self._setArray(6, value)

    @staticmethod
    def getLevelsType():
        return ArmoryYardLevelModel

    def getQuests(self):
        return self._getArray(7)

    def setQuests(self, value):
        self._setArray(7, value)

    @staticmethod
    def getQuestsType():
        return ArmoryYardQuestModel

    def getAnimationLevel(self):
        return self._getNumber(8)

    def setAnimationLevel(self, value):
        self._setNumber(8, value)

    def getLevelDuration(self):
        return self._getNumber(9)

    def setLevelDuration(self, value):
        self._setNumber(9, value)

    def getFromTimestamp(self):
        return self._getNumber(10)

    def setFromTimestamp(self, value):
        self._setNumber(10, value)

    def getToTimestamp(self):
        return self._getNumber(11)

    def setToTimestamp(self, value):
        self._setNumber(11, value)

    def getAnimationStatus(self):
        return AnimationStatus(self._getNumber(12))

    def setAnimationStatus(self, value):
        self._setNumber(12, value.value)

    def getReplay(self):
        return self._getBool(13)

    def setReplay(self, value):
        self._setBool(13, value)

    def _initialize(self):
        super(ArmoryYardMainViewModel, self)._initialize()
        self._addViewModelProperty('finalReward', ArmoryYardRewardsVehicleModel())
        self._addNumberProperty('tabId')
        self._addNumberProperty('currentLevel', 0)
        self._addNumberProperty('viewedLevel', 0)
        self._addNumberProperty('rewardStatus')
        self._addArrayProperty('chapters', Array())
        self._addArrayProperty('levels', Array())
        self._addArrayProperty('quests', Array())
        self._addNumberProperty('animationLevel', 0)
        self._addNumberProperty('levelDuration', 0)
        self._addNumberProperty('fromTimestamp', 0)
        self._addNumberProperty('toTimestamp', 0)
        self._addNumberProperty('animationStatus')
        self._addBoolProperty('replay', False)
        self.onMoveSpace = self._addCommand('onMoveSpace')
        self.onStartMoving = self._addCommand('onStartMoving')
        self.onTabChange = self._addCommand('onTabChange')
        self.onClose = self._addCommand('onClose')
        self.onPlayAnimation = self._addCommand('onPlayAnimation')
        self.onSkipAnimation = self._addCommand('onSkipAnimation')
        self.onAboutEvent = self._addCommand('onAboutEvent')
        self.onCollectReward = self._addCommand('onCollectReward')
        self.onBuyTokens = self._addCommand('onBuyTokens')
        self.onShowVehiclePreview = self._addCommand('onShowVehiclePreview')