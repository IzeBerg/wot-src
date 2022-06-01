from gui.battle_control.controllers.hit_direction_ctrl.base import HitType, IHitIndicator
from gui.battle_control.controllers.hit_direction_ctrl.ctrl import HitDirectionControllerPlayer, HitDirectionController
__all__ = ('HitType', 'IHitIndicator', 'createHitDirectionController')

def createHitDirectionController(setup):
    if setup.isReplayPlaying:
        return HitDirectionControllerPlayer(setup)
    return HitDirectionController(setup)