from gui.Scaleform.daapi.view.battle.shared.messages import VehicleMessages

class HalloweenVehicleMessages(VehicleMessages):

    def _addGameListeners(self):
        super(HalloweenVehicleMessages, self)._addGameListeners()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched += self._onPostMortemSwitched
        return

    def _removeGameListeners(self):
        super(HalloweenVehicleMessages, self)._removeGameListeners()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched -= self._onPostMortemSwitched
        return

    def _onPostMortemSwitched(self, noRespawnPossible, respawnAvailable):
        self.clear()