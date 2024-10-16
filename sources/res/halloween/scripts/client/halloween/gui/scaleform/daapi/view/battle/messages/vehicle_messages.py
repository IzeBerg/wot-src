from gui.Scaleform.daapi.view.battle.shared.messages import VehicleMessages

class HalloweenVehicleMessages(VehicleMessages):
    _SKIP_EVENT_KEYS = ('DEVICE_CRITICAL_AT_WORLD_COLLISION', 'DEVICE_DESTROYED_AT_WORLD_COLLISION',
                        'DEVICE_CRITICAL_AT_RAMMING', 'DEVICE_DESTROYED_AT_RAMMING',
                        'DEVICE_STARTED_FIRE_AT_RAMMING', 'TANKMAN_HIT_AT_WORLD_COLLISION',
                        'DEVICE_CRITICAL_AT_SHOT', 'DEVICE_DESTROYED_AT_SHOT', 'DEVICE_STARTED_FIRE_AT_SHOT',
                        'TANKMAN_HIT_AT_SHOT', 'TANKMAN_RESTORED', 'TANKMAN_HIT_AT_MEDKIT_OVER',
                        'DEVICE_CRITICAL_AT_FIRE', 'DEVICE_DESTROYED_AT_FIRE', 'DEVICE_REPAIRED_TO_CRITICAL',
                        'DEVICE_REPAIRED', 'DEVICE_CRITICAL_AT_REPAIRKIT_OVER', 'ENGINE_CRITICAL_AT_UNLIMITED_RPM',
                        'ENGINE_DESTROYED_AT_UNLIMITED_RPM', 'ENGINE_CRITICAL_AT_BURNOUT',
                        'ENGINE_DESTROYED_AT_BURNOUT', 'FIRE_STOPPED', 'OPT_DEVICE_USED',
                        'SCREENSHOT_CREATED', 'DRR_SCALE_STEP_UP', 'DRR_SCALE_STEP_DOWN')

    def showMessage(self, key, args=None, extra=None, postfix=''):
        if any(key.startswith(event) for event in self._SKIP_EVENT_KEYS):
            return
        super(HalloweenVehicleMessages, self).showMessage(key, args, extra, postfix)

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

    def _getPlayerInfo(self, entityID):
        ctx = self.sessionProvider.getCtx()
        vInfo = ctx.getArenaDP().getVehicleInfo(entityID)
        if vInfo.isEnemy():
            return vInfo.vehicleType.name
        return super(HalloweenVehicleMessages, self)._getPlayerInfo(entityID)