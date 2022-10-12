from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS as BONUS_CAPS
from constants import ARENA_BONUS_TYPE
from gui.Scaleform.daapi.view.common.filter_popover import FILTER_SECTION, BattlePassCarouselFilterPopover
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext

class FunRandomCarouselFilterPopover(BattlePassCarouselFilterPopover):
    __lobbyContext = dependency.descriptor(ILobbyContext)

    @classmethod
    def _generateMapping(cls, hasRented, hasEvent, hasRoles, **kwargs):
        mapping = super(FunRandomCarouselFilterPopover, cls)._generateMapping(hasRented, hasEvent, hasRoles, **kwargs)
        mapping[FILTER_SECTION.SPECIALS].append('funRandom')
        config = cls.__lobbyContext.getServerSettings().getCrystalRewardConfig()
        if not config.isCrystalEarnPossible(ARENA_BONUS_TYPE.FUN_RANDOM):
            mapping[FILTER_SECTION.SPECIALS].remove('crystals')
        if not BONUS_CAPS.checkAny(ARENA_BONUS_TYPE.FUN_RANDOM, BONUS_CAPS.DAILY_MULTIPLIED_XP):
            mapping[FILTER_SECTION.SPECIALS].remove('bonus')
        return mapping