import logging
from constants import ARENA_GUI_TYPE
from gui.doc_loaders.prebattle_tips_loader import readPreBattleTips
from gui.impl.gen import R
from helpers.tips import TipsCriteria, _randomTips, _readTips
_logger = logging.getLogger(__name__)
_VERSUS_AI_PREBATTLE_TIPS_XML_PATH = 'versus_ai/gui/prebattle_tips.xml'

def readVersusAITips():
    tips = [ (tipID, descriptionResId) for tipID, descriptionResId in R.strings.versusAI.prebattleTips.items() if tipID ]
    return _readTips(tips, _versusAITipsConfig, _logger)


class VersusAiTipsCriteria(TipsCriteria):

    def _getTargetList(self):
        return _versusAiTips + _randomTips

    def _getArenaGuiType(self):
        return ARENA_GUI_TYPE.VERSUS_AI


_versusAITipsConfig = readPreBattleTips(_VERSUS_AI_PREBATTLE_TIPS_XML_PATH)
_versusAiTips = readVersusAITips()