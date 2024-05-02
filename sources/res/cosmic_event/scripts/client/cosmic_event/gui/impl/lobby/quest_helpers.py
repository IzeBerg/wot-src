import typing
from gui.shared.missions.packers.events import findFirstConditionModel
from cosmic_event.gui.impl.lobby.quest_packer import DailyCosmicQuestUIDataPacker
from gui.impl.gen.view_models.common.missions.event_model import EventStatus
if typing.TYPE_CHECKING:
    from typing import Optional
    from gui.impl.gen.view_models.common.missions.daily_quest_model import DailyQuestModel
    from gui.impl.gen.view_models.common.missions.conditions.preformatted_condition_model import PreformattedConditionModel
    from gui.server_events.event_items import Quest
    from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.mission_model import MissionModel

def getDailyQuestModelFromQuest(quest):
    questUIPacker = DailyCosmicQuestUIDataPacker(quest)
    return questUIPacker.pack()


def fillDailyQuestModel(questModel, fullQuestModel):
    preFormattedConditionModel = _getFirstConditionModelFromQuestModel(fullQuestModel)
    if preFormattedConditionModel is not None:
        questModel.setCurrentProgress(preFormattedConditionModel.getCurrent())
        questModel.setTotalProgress(preFormattedConditionModel.getTotal())
        questModel.setEarned(preFormattedConditionModel.getEarned())
        questModel.setDescription(preFormattedConditionModel.getDescrData())
    questModel.setId(fullQuestModel.getId())
    questModel.setIcon(fullQuestModel.getIcon())
    questModel.setTitle(fullQuestModel.getTitle())
    questModel.setCompleted(fullQuestModel.getStatus() == EventStatus.DONE)
    packedBonuses = fullQuestModel.getBonuses()
    targetModelBonuses = questModel.getBonuses()
    targetModelBonuses.clear()
    targetModelBonuses.reserve(len(packedBonuses))
    for packedIdx, packedBonus in enumerate(packedBonuses):
        packedBonus.setIndex(packedIdx)
        targetModelBonuses.addViewModel(packedBonus)

    targetModelBonuses.invalidate()
    return


def _getFirstConditionModelFromQuestModel(dailyQuestModel):
    postBattleModel = findFirstConditionModel(dailyQuestModel.postBattleCondition)
    bonusConditionModel = findFirstConditionModel(dailyQuestModel.bonusCondition)
    if postBattleModel:
        return postBattleModel
    return bonusConditionModel