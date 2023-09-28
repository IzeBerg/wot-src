import BigWorld
from gui.Scaleform.daapi.view.battle.shared.damage_panel import DamagePanel
from buffs_helpers import ValueSimpleModifier
from gui.Scaleform.daapi.view.battle.shared.formatters import formatHealthProgress, normalizeHealthPercent

class HalloweenDamagePanel(DamagePanel):

    def updateVehicleParams(self, vehicle, _, vehicleID):
        modifiers = BigWorld.entity(vehicleID).hwMaxHealthModifier.modifiers
        if modifiers:
            maxHealth = vehicle.descriptor.maxHealth
            maxHealthModifiers = modifiers.getModifiers('maxHealth')
            newHealth, _ = ValueSimpleModifier(maxHealthModifiers).apply(maxHealth)
            if newHealth is not None:
                maxHealth = newHealth
            self._maxHealth = maxHealth
            self._updateHealth(maxHealth)
        else:
            super(HalloweenDamagePanel, self).updateVehicleParams(vehicle, _, vehicleID)
        return

    def _updateHealth(self, health):
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            vehicle = ctrl.getControllingVehicle()
            self._maxHealth = vehicle.maxHealth
            arenaDP = self.sessionProvider.getArenaDP()
            if arenaDP:
                playerVehType = arenaDP.getVehicleInfo(vehicle.id).vehicleType
                self._maxHealth = playerVehType.maxHealth
        if health <= self._maxHealth and self._maxHealth > 0:
            healthStr = formatHealthProgress(health, self._maxHealth)
            healthProgress = normalizeHealthPercent(health, self._maxHealth)
            self.as_updateHealthS(healthStr, healthProgress)
        return