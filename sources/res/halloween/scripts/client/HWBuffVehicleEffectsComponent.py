import BigWorld
from helpers import dependency
from HWBuffSequencesComponent import HWBuffSequencesComponent
from skeletons.gui.battle_session import IBattleSessionProvider
from dyn_components_groups import groupComponent
from xml_config_specs import StrParam
from VehicleEffects import DamageFromShotDecoder
from constants import VEHICLE_HIT_EFFECT

@groupComponent(moduleName=StrParam())
class HWBuffVehicleEffectsComponent(HWBuffSequencesComponent):
    _guiSessionProvider = dependency.descriptor(IBattleSessionProvider)
    _START_TRIGGER = 'start_trigger'
    _DEATH_MODULE = 'death'

    def onDestroy(self):
        self.entity.onShowDamageFromShot -= self._onShowDamageFromShot
        BigWorld.player().arena.onVehicleKilled -= self._onVehicleKilled
        super(HWBuffVehicleEffectsComponent, self).onDestroy()

    def _onAvatarReady(self):
        super(HWBuffVehicleEffectsComponent, self)._onAvatarReady()
        self.entity.onShowDamageFromShot += self._onShowDamageFromShot
        BigWorld.player().arena.onVehicleKilled += self._onVehicleKilled

    def _onShowDamageFromShot(self, attackerID, points, effectsIndex, damageFactor, lastMaterialIsShield):
        maxComponentIdx = self.entity.calcMaxComponentIdx()
        decodedPoints = DamageFromShotDecoder.decodeHitPoints(points, self.entity.appearance.collisions, maxComponentIdx, self.entity.typeDescriptor)
        if not decodedPoints:
            return
        maxPriorityHitPoint = decodedPoints[(-1)]
        maxHitEffectCode = maxPriorityHitPoint.hitEffectCode
        hasPiercedHit = maxHitEffectCode in VEHICLE_HIT_EFFECT.PIERCED_HITS
        moduleName = maxPriorityHitPoint.componentName
        if hasPiercedHit and moduleName == self.groupComponentConfig.moduleName:
            self._triggerEffects(self._START_TRIGGER)

    def _onVehicleKilled(self, victimID, killerID, equipmentID, reason, numVehiclesAffected):
        if self.entity.id == victimID:
            if self.groupComponentConfig.moduleName == self._DEATH_MODULE:
                self._triggerEffects(self._START_TRIGGER)