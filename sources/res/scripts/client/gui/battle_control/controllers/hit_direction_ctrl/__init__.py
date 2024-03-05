from gui.battle_control.controllers.hit_direction_ctrl.base import HitType, IHitIndicator
from gui.battle_control.controllers.hit_direction_ctrl.ctrl import HitDirectionControllerPlayer, HitDirectionController
from gui.shared.system_factory import collectHitDirectionController
__all__ = ('HitType', 'IHitIndicator', 'createHitDirectionController')

def createHitDirectionController(setup):
    hitDirectionControllerType, hitDirectionControllerPlayerType = collectHitDirectionController(setup.arenaVisitor.gui.guiType, HitDirectionController, HitDirectionControllerPlayer)
    if setup.isReplayPlaying:
        return hitDirectionControllerPlayerType(setup)
    return hitDirectionControllerType(setup)