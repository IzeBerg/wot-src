from constants import ARENA_GUI_TYPE
from gui.Scaleform.daapi.settings import config as sf_config
from gui.shared.system_factory import registerScaleformBattlePackages

def registerCosmicEventBattlePackages():
    registerScaleformBattlePackages(ARENA_GUI_TYPE.COSMIC_EVENT, sf_config.BATTLE_PACKAGES + ('cosmic_event.gui.Scaleform.daapi.view.battle.cosmic', ))