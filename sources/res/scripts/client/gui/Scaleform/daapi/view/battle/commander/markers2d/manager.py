from gui.battle_control import avatar_getter
from gui.battle_control.controllers.commander.common import FocusPriority
from gui.Scaleform.daapi.view.battle.commander.markers2d import plugins
from gui.Scaleform.daapi.view.battle.shared.markers2d import MarkersManager
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class CommanderMarkersManager(MarkersManager):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(CommanderMarkersManager, self).__init__()
        self.__previousFocusedVehID = 0

    def _setupPlugins(self, arenaVisitor):
        setup = super(CommanderMarkersManager, self)._setupPlugins(arenaVisitor)
        if avatar_getter.isPlayerCommander():
            if arenaVisitor.gui.isRTSBootcamp():
                from bootcamp.BootcampGUI import BootcampStaticObjectsPlugin
                setup['bootcamp'] = BootcampStaticObjectsPlugin
            setup['vehicles'] = plugins.RTSCommanderMarkerPlugin
            setup['orders'] = plugins.RTSOrdersMarkerPlugin
            setup['area'] = plugins.DisabledMarkerPlugin
            setup['supplies'] = plugins.CommanderSupplyMarkerPlugin
        else:
            setup['vehicles'] = plugins.RTSTankmanMarkerPlugin
            setup['supplies'] = plugins.TankmanSupplyMarkerPlugin
        return setup

    def setFocusVehicle(self, vehicleID):
        vehID = int(vehicleID)
        if avatar_getter.isCommanderCtrlMode():
            vehicles = self.__sessionProvider.dynamic.rtsCommander.vehicles
            vehicles.setFocusVehicle(vehID, True, FocusPriority.MARKER)