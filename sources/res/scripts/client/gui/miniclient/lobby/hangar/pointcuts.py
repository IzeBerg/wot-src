import aspects
from helpers import aop

class ShowMiniclientInfo(aop.Pointcut):

    def __init__(self):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.lobby.hangar.Hangar', 'Hangar', '_populate', aspects=(
         aspects.ShowMiniclientInfo,))


class DisableTankServiceButtons(aop.Pointcut):

    def __init__(self, config):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.lobby.hangar.Hangar', 'Hangar', 'as_setupAmmunitionPanelS', aspects=(
         aspects.DisableTankServiceButtons(config),))


class TankModelHangarVisibility(aop.Pointcut):

    def __init__(self, config):
        aop.Pointcut.__init__(self, 'CurrentVehicle', '_CurrentVehicle', 'isInHangar', aspects=(
         aspects.TankModelHangarVisibility(config),))


class TankHangarStatus(aop.Pointcut):

    def __init__(self, config):
        aop.Pointcut.__init__(self, 'CurrentVehicle', '_CurrentVehicle', 'getHangarMessage', aspects=(
         aspects.TankHangarStatus(config),))


class EnableCrew(aop.Pointcut):

    def __init__(self, config):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.lobby.hangar.Hangar', 'Hangar', 'as_setCrewEnabledS', aspects=(
         aspects.EnableCrew(config),))


class ChangeLobbyMenuTooltip(aop.Pointcut):

    def __init__(self):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.lobby', 'LobbyMenu', '_getVersionMessage', aspects=(
         aspects.ChangeLobbyMenuTooltip,))