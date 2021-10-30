from helpers import aop
from bootcamp.aop import common

def weave(weaver, stateBattlePreparing):
    weaver.weave(pointcut=_PointcutDelayStartFirstBattle(stateBattlePreparing))


class _PointcutDelayStartFirstBattle(aop.Pointcut):

    def __init__(self, stateBattlePreparing):
        super(_PointcutDelayStartFirstBattle, self).__init__('Avatar', 'PlayerAvatar', '^(vehicle_onAppearanceReady|onEnterWorld|onSpaceLoaded)$', aspects=(
         common.AspectRedirectMethod({'vehicle_onAppearanceReady': stateBattlePreparing.onVehicleOnAppearanceReady, 
            'onEnterWorld': stateBattlePreparing.onAvatarOnEnterWorld, 
            'onSpaceLoaded': stateBattlePreparing.onSpaceLoaded}),))