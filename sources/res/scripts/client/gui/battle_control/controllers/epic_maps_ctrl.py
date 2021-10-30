import Event
from chat_commands_consts import INVALID_VEHICLE_POSITION
import CommandMapping
from gui.battle_control import event_dispatcher as gui_event_dispatcher
import Math
from gui.battle_control.controllers.default_maps_ctrl import DefaultMapsController

class EpicMapsController(DefaultMapsController):

    def __init__(self, setup):
        super(EpicMapsController, self).__init__(setup)
        self.__overviewMapUi = None
        self.__isOverlayActive = True
        self.__overviewMapScreenVisible = False
        self.__savedToggleState = False
        self.onOverlayTriggered = Event.Event(self._eManager)
        self.onVisibilityChanged = Event.Event(self._eManager)
        return

    def setViewComponents(self, *components):
        if len(components) >= 2:
            self.__overviewMapUi = components[0]
            self._miniMapUi = components[1]
            self.__overviewMapUi.start()
        else:
            self._miniMapUi = components[0]

    def stopControl(self):
        self._eManager.clear()
        self._eManager = None
        return

    def clearViewComponents(self):
        self.__overviewMapUi = None
        self._miniMapUi = None
        return

    def getMinimapZoomMode(self):
        if self._miniMapUi is not None:
            return self._miniMapUi.getZoomMode()
        else:
            return 1

    def getMinimapCenterPosition(self):
        if self._miniMapUi is not None:
            return self._miniMapUi.getCenterPosition()
        else:
            return Math.Vector3(0, 0, 0)

    def getVehiclePosition(self, vID):
        if self._miniMapUi is not None:
            return self._miniMapUi.getPositionOfEntry(vID)
        else:
            return INVALID_VEHICLE_POSITION

    def overlayTriggered(self, isActive):
        self.__isOverlayActive = isActive
        self.onOverlayTriggered(self.__isOverlayActive)

    @property
    def overlayActive(self):
        return self.__isOverlayActive

    @property
    def overviewMapScreenVisible(self):
        return self.__overviewMapScreenVisible

    def setOverviewMapScreenVisibility(self, isVisible):
        if isVisible == self.__overviewMapScreenVisible:
            return
        self.__overviewMapScreenVisible = isVisible
        self.onVisibilityChanged(isVisible)
        if isVisible:
            self.overlayTriggered(True)

    def overviewMapTriggered(self):
        gui_event_dispatcher.setMinimapCmd(CommandMapping.g_instance.get('CMD_MINIMAP_VISIBLE'))