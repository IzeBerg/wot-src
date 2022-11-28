import logging, typing, constants
from gui.Scaleform.genConsts.MISSIONS_STATES import MISSIONS_STATES
from gui.Scaleform.daapi.view.lobby.missions.awards_formatters import CurtailingAwardsComposer
from gui.Scaleform.daapi.view.lobby.missions.missions_helper import getMissionInfoData
from gui.impl.gen.view_models.common.missions.conditions.preformatted_condition_model import PreformattedConditionModel
from gui.impl.gen.view_models.common.missions.daily_quest_model import DailyQuestModel
from gui.impl.gen.view_models.common.missions.quest_model import QuestModel
from gui.server_events.awards_formatters import AWARDS_SIZES
from gui.server_events.events_helpers import isPremium, isDailyQuest
from gui.server_events.formatters import DECORATION_SIZES
from gui.shared.missions.packers.bonus import getDefaultBonusPacker, packBonusModelAndTooltipData
from gui.shared.missions.packers.conditions import PostBattleConditionPacker
from gui.shared.missions.packers.conditions import BonusConditionPacker
from helpers import dependency
from skeletons.gui.server_events import IEventsCache
from soft_exception import SoftException
if typing.TYPE_CHECKING:
    from gui.server_events.event_items import ServerEventAbstract
    from gui.server_events.bonuses import SimpleBonus
    from gui.shared.missions.packers.bonus import BonusUIPacker
_logger = logging.getLogger(__name__)
DEFAULT_AWARDS_COUNT = 10
DAILY_QUEST_AWARDS_COUNT = 1000

class _EventUIDataPacker(object):

    def __init__(self, event):
        self._event = event

    def pack(self, model=None):
        raise SoftException('This function should be overriden.')

    def _packModel(self, model):
        self._packEvent(model)

    def _packEvent(self, model):
        with model.transaction() as (ts):
            ts.setId(self._event.getID())
            ts.setGroupId(self._event.getGroupID())
            ts.setType(self._event.getType())
            ts.setTitle(self._event.getUserName())
            ts.setDescription(self._event.getDescription())
            ts.setStatus(self._getStatus())
            ts.setDecoration(self._event.getIconID())
        return model

    def _getStatus(self):
        if self._event.isCompleted():
            return MISSIONS_STATES.COMPLETED
        if self._event.isAvailable()[0]:
            return MISSIONS_STATES.NONE
        return MISSIONS_STATES.NOT_AVAILABLE


class BattleQuestUIDataPacker(_EventUIDataPacker):

    def __init__(self, event, bonusFormatter=CurtailingAwardsComposer(DEFAULT_AWARDS_COUNT)):
        super(BattleQuestUIDataPacker, self).__init__(event)
        self._tooltipData = {}
        self._bonusFormatter = bonusFormatter

    def pack(self, model=None):
        if model is not None and not isinstance(model, QuestModel):
            _logger.error('Provided model type is not matching quest type. Expected QuestModel')
            return
        else:
            model = model if model is not None else QuestModel()
            self._packModel(model)
            return model

    def getTooltipData(self):
        return self._tooltipData

    def _packModel(self, model):
        super(BattleQuestUIDataPacker, self)._packModel(model)
        self._packBonuses(model)
        self._packPostBattleConds(model)
        self._packBonusConds(model)
        self._packDefaultConds(model)

    def _packBonuses(self, model):
        self._tooltipData = {}
        packer = getDefaultBonusPacker()
        packQuestBonusModelAndTooltipData(packer, model.getBonuses(), self._event, tooltipData=self._tooltipData)

    def _packPostBattleConds(self, model):
        postBattleContitionPacker = PostBattleConditionPacker()
        postBattleContitionPacker.pack(self._event, model.postBattleCondition)

    def _packBonusConds(self, model):
        bonusConditionPacker = BonusConditionPacker()
        bonusConditionPacker.packWithPostBattleCondCheck(self._event, model.bonusCondition, bool(model.postBattleCondition.getItems()))

    @staticmethod
    def _packDefaultConds(model):
        if not model.bonusCondition.getItems() and not model.postBattleCondition.getItems():
            postBattleContitionPacker = PostBattleConditionPacker()
            postBattleContitionPacker.packDefaultCondition(model.postBattleCondition)


class TokenUIDataPacker(_EventUIDataPacker):

    def pack(self, model=None):
        if model is not None and not isinstance(model, QuestModel):
            _logger.error('Provided model type is not matching quest type. Expected QuestModel')
            return
        else:
            model = model if model is not None else QuestModel()
            self._packModel(model)
            return model


class PrivateMissionUIDataPacker(_EventUIDataPacker):
    pass


class DailyQuestUIDataPacker(BattleQuestUIDataPacker):
    eventsCache = dependency.descriptor(IEventsCache)
    _NY_BONUSES_ORDER = ('battleToken', 'entitlements')

    def pack(self, model=None):
        if model is not None and not isinstance(model, DailyQuestModel):
            _logger.error('Provided model type is not matching quest type. Expected DailyQuestModel')
            return
        else:
            model = model if model is not None else DailyQuestModel()
            self._packModel(model)
            self.__resolveQuestIcon(model)
            return model

    def _packBonuses(self, model):
        self._tooltipData = {}
        packer = getDefaultBonusPacker()
        bonuses = sorted(self._event.getBonuses(), key=self.__keySortOrder)
        packQuestBonusModelAndTooltipData(packer, model.getBonuses(), self._event, self._tooltipData, bonuses)

    def __keySortOrder(self, bonus):
        if bonus.getName() in self._NY_BONUSES_ORDER:
            return self._NY_BONUSES_ORDER.index(bonus.getName())
        return len(self._NY_BONUSES_ORDER)

    def __resolveQuestIcon(self, model):
        iconId = self._event.getIconID()
        if iconId is not None and iconId > 0:
            prefetcher = self.eventsCache.prefetcher
            questIcon = prefetcher.getMissionDecoration(iconId, DECORATION_SIZES.DAILY)
            if not questIcon:
                _logger.error('Failed to prefetch daily quest icon from uiDecorator %s', str(iconId))
        else:
            conditionModel = findFirstConditionModel(model.bonusCondition)
            if conditionModel is None:
                conditionModel = findFirstConditionModel(model.postBattleCondition)
                if conditionModel is None:
                    _logger.warning('No condition found. Unable to define quest icon.')
                    return
            questIcon = conditionModel.getIconKey()
        model.setIcon(questIcon)
        return


def packQuestBonusModel(quest, packer, array):
    bonuses = quest.getBonuses()
    for bonus in bonuses:
        if bonus.isShowInGUI():
            bonusList = packer.pack(bonus)
            for idx, item in enumerate(bonusList):
                item.setIndex(idx)
                array.addViewModel(item)


def packQuestBonusModelAndTooltipData(packer, array, quest, tooltipData=None, questBonuses=None):
    bonuses = quest.getBonuses() if questBonuses is None else questBonuses
    packBonusModelAndTooltipData(bonuses, packer, array, tooltipData)
    return


def preformatEventBonuses(event, bonusFormatter=CurtailingAwardsComposer(DEFAULT_AWARDS_COUNT)):
    bonuses = getMissionInfoData(event).getSubstituteBonuses()
    return bonusFormatter.getFormattedBonuses(bonuses, size=AWARDS_SIZES.BIG)


def getEventUIDataPacker(event):
    if event.getType() == constants.EVENT_TYPE.TOKEN_QUEST:
        return TokenUIDataPacker(event)
    else:
        if event.getType() == constants.EVENT_TYPE.PERSONAL_QUEST:
            return PrivateMissionUIDataPacker(event)
        if isPremium(event.getID()) or isDailyQuest(event.getID()):
            return DailyQuestUIDataPacker(event)
        if event.getType() in constants.EVENT_TYPE.LIKE_BATTLE_QUESTS:
            return BattleQuestUIDataPacker(event)
        return


def findFirstConditionModel(root):
    if not hasattr(root, 'getItems'):
        return root
    else:
        for item in root.getItems():
            return findFirstConditionModel(item)

        return