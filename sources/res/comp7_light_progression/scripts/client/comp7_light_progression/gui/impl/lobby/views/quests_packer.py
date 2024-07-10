import logging
from comp7_light_progression.gui.impl.lobby.views.bonus_packer import getBonusPacker
import constants
from gui.shared.missions.packers.bonus import BonusUIPacker
from gui.shared.missions.packers.events import DailyQuestUIDataPacker, packQuestBonusModelAndTooltipData
_logger = logging.getLogger(__name__)

class Comp7LightDailyQuestUIDataPacker(DailyQuestUIDataPacker):

    def _packBonuses(self, model):
        packer = getBonusPacker()
        self._tooltipData = {}
        packQuestBonusModelAndTooltipData(packer, model.getBonuses(), self._event, tooltipData=self._tooltipData)


def getEventUIDataPacker(event):
    if event.getType() in constants.EVENT_TYPE.LIKE_BATTLE_QUESTS:
        return Comp7LightDailyQuestUIDataPacker(event)
    else:
        _logger.warning('Only LIKE_BATTLE_QUESTS allowed')
        return