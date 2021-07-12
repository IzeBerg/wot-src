from helpers import aop

def weave(weaver):
    weaver.weave(pointcut=_PointcutToggleFullStats, avoid=True)
    weaver.weave(pointcut=_PointcutComputePiercingPowerAtDist)
    weaver.weave(pointcut=_PointcutComputePiercingPowerRandomization)
    weaver.weave(pointcut=_PointcutKeepArenaSoundsPlayingOnResultScreen)


class _PointcutToggleFullStats(aop.Pointcut):

    def __init__(self):
        super(_PointcutToggleFullStats, self).__init__('gui.battle_control', 'event_dispatcher', 'toggleFullStats')


class _PointcutComputePiercingPowerAtDist(aop.Pointcut):

    def __init__(self):
        super(_PointcutComputePiercingPowerAtDist, self).__init__('AvatarInputHandler', 'gun_marker_ctrl', '_computePiercingPowerAtDistImpl', aspects=(
         _AspectComputePiercingPowerAtDist,))


class _PointcutComputePiercingPowerRandomization(aop.Pointcut):

    def __init__(self):
        super(_PointcutComputePiercingPowerRandomization, self).__init__('AvatarInputHandler', 'gun_marker_ctrl', '_computePiercingPowerRandomizationImpl', aspects=(
         _AspectComputePiercingPowerRandomization,))


class _PointcutKeepArenaSoundsPlayingOnResultScreen(aop.Pointcut):

    def __init__(self):
        super(_PointcutKeepArenaSoundsPlayingOnResultScreen, self).__init__('SoundGroups', 'SoundGroups', 'enableArenaSounds', aspects=(
         _AspectKeepArenaSoundsPlayingOnResultScreen,))


class _AspectComputePiercingPowerAtDist(aop.Aspect):

    def atCall(self, cd):
        from bootcamp.Bootcamp import g_bootcamp
        bootcampPP = g_bootcamp.getPredefinedPiercingPower()
        if bootcampPP:
            cd.avoid()
            piercingPower = bootcampPP['data'][0][1]
            return piercingPower


class _AspectComputePiercingPowerRandomization(aop.Aspect):

    def atCall(self, cd):
        from bootcamp.Bootcamp import g_bootcamp
        if g_bootcamp.getPredefinedPiercingPower():
            cd.avoid()
            return (100.0, 100.0)


class _AspectKeepArenaSoundsPlayingOnResultScreen(aop.Aspect):

    def atCall(self, cd):
        enable = cd.findArg(0, 'enable')
        if not enable:
            cd.avoid()