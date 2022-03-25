from gui.battle_control.avatar_getter import isPlayerCommander
from gui.battle_control.controllers.hit_direction_ctrl.base import HitType, IHitIndicator
from gui.battle_control.controllers.hit_direction_ctrl.ctrl import HitDirectionControllerPlayer, HitDirectionController
from gui.battle_control.controllers.hit_direction_ctrl.rts_ctrl import RTSHitDirectionControllerPlayer, RTSHitDirectionController
__all__ = ('HitType', 'IHitIndicator', 'createHitDirectionController')

def createHitDirectionController(setup):
    if isPlayerCommander(setup.avatar):
        if setup.isReplayPlaying:
            return RTSHitDirectionControllerPlayer(setup)
        return RTSHitDirectionController(setup)
    if setup.isReplayPlaying:
        return HitDirectionControllerPlayer(setup)
    return HitDirectionController(setup)