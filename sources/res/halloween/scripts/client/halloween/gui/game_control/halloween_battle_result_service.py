from gui.battle_results.service import BattleResultsService
from halloween_common.halloween_constants import ARENA_BONUS_TYPE

class HalloweenBattleResultService(BattleResultsService):

    def _isShowImmediately(self, arenaBonusType):
        return arenaBonusType not in (ARENA_BONUS_TYPE.HALLOWEEN_BATTLES,
         ARENA_BONUS_TYPE.HALLOWEEN_BATTLES_WHEEL)