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

    def _getVehicleName(self, entityID):
        ctx = self.sessionProvider.getCtx()
        vInfo = ctx.getArenaDP().getVehicleInfo(entityID)
        if vInfo.isEnemy():
            return vInfo.vehicleType.name
        return super(HalloweenVehicleMessages, self)._getVehicleName(entityID)