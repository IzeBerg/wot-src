from constants import ARENA_BONUS_TYPE
from battle_royale.gui.impl.gen.view_models.views.lobby.views.tank_setup_panel_view_model import TankSetupPanelViewModel
from gui.impl.gen import R
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController

class RespawnAbility(object):
    __brController = dependency.descriptor(IBattleRoyaleController)
    name = R.strings.artefacts.br_respawn.name()
    description = R.strings.artefacts.br_respawn.solo.descr()
    icon = R.images.gui.maps.icons.battleRoyale.artefact.respawn()
    tooltipType = TankSetupPanelViewModel.TOOLTIP_RESPAWN
    soloTooltip = R.strings.artefacts.br_respawn.solo
    platoonTooltip = R.strings.artefacts.br_respawn.platoon

    @classmethod
    def getSoloRespawnPeriod(cls):
        return int(cls._getParams(ARENA_BONUS_TYPE.BATTLE_ROYALE_SOLO, 'respawnPeriod'))

    @classmethod
    def getPlatoonRespawnPeriod(cls):
        return int(cls._getParams(ARENA_BONUS_TYPE.BATTLE_ROYALE_SQUAD, 'respawnPeriod'))

    @classmethod
    def getPlatoonTimeToRessurect(cls):
        return cls._getParams(ARENA_BONUS_TYPE.BATTLE_ROYALE_SQUAD, 'timeToRessurect')

    @classmethod
    def _getParams(cls, battleType, key):
        config = cls.__brController.getModeSettings().respawns.get(battleType)
        if config:
            return config[key]