from gui.doc_loaders import messages_panel_reader
from gui.Scaleform.daapi.view.battle.shared.messages import VehicleErrorMessages

class HalloweenVehicleErrorMessages(VehicleErrorMessages):
    HW_XML_PATH = 'halloween/gui/vehicle_errors_panel.xml'

    def _populate(self):
        super(HalloweenVehicleErrorMessages, self)._populate()
        _, _, hwMessages = messages_panel_reader.readXML(self.HW_XML_PATH)
        self.messages.update(hwMessages)

    def _addGameListeners(self):
        super(HalloweenVehicleErrorMessages, self)._addGameListeners()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched += self._onPostMortemSwitched
        return

    def _removeGameListeners(self):
        super(HalloweenVehicleErrorMessages, self)._removeGameListeners()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched -= self._onPostMortemSwitched
        return

    def _onPostMortemSwitched(self, noRespawnPossible, respawnAvailable):
        self.clear()