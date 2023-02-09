from gui.impl.gen import R
from gui.Scaleform.daapi.view.lobby.lobby_vehicle_marker_view import LobbyVehicleMarkerView
from gui.shared import EVENT_BUS_SCOPE
from gui.shared.events import HangarVehicleEvent

class BCLobbyVehicleMarkerView(LobbyVehicleMarkerView):

    def _populate(self):
        self.addListener(HangarVehicleEvent.BOOTCAMP_SECOND_TANK_MARKER, self._onBootcampSecondTankMarker, EVENT_BUS_SCOPE.LOBBY)
        super(BCLobbyVehicleMarkerView, self)._populate()

    def _dispose(self):
        self.removeListener(HangarVehicleEvent.BOOTCAMP_SECOND_TANK_MARKER, self._onBootcampSecondTankMarker, EVENT_BUS_SCOPE.LOBBY)
        super(BCLobbyVehicleMarkerView, self)._dispose()

    def _onBootcampSecondTankMarker(self, event):
        if event.ctx['isVisible']:
            self._onPlatoonTankLoaded(event)
        else:
            self._onHeroPlatoonTankDestroy(event)

    def _canShowMarkers(self):
        windowsManager = self.guiLoader.windowsManager
        if windowsManager.getViewByLayoutID(R.views.lobby.bootcamp.BootcampNationView()) is not None:
            return True
        else:
            return super(BCLobbyVehicleMarkerView, self)._canShowMarkers()

    def as_createPlatoonMarkerS(self, id, _, pName):
        return super(BCLobbyVehicleMarkerView, self).as_createPlatoonMarkerS(id, '', pName)