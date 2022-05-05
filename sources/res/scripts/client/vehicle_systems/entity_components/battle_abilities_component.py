import BigWorld
from . import VehicleComponent

class BattleAbilitiesComponent(VehicleComponent):

    def _getEquipmentComp(self):
        componentSystem = BigWorld.player().arena.componentSystem
        if componentSystem is not None:
            return getattr(componentSystem, 'arenaEquipmentComponent', None)
        else:
            return

    def refreshBuffEffects(self):
        self.set_inspiringEffect()
        self.set_inspired()
        self.set_healingEffect()
        self.set_healing()
        self.set_debuff()
        self.set_healOverTime()

    def set_inspiringEffect(self, prev=None):
        if not self.isStarted or self.inspiringEffect == prev:
            return
        data = self.inspiringEffect
        equipmentComp = self._getEquipmentComp()
        equipmentID = self.inspired.equipmentID if self.inspired is not None else None
        if equipmentComp is not None:
            if data is not None:
                radius = data.radius if data.radius > 0 else None
                equipmentComp.updateInspiringSource(self.id, data.startTime, data.endTime, data.inactivationDelay, radius, equipmentID)
            else:
                equipmentComp.updateInspiringSource(self.id, None, None, None, None, None)
        return

    def set_inspired(self, prev=None):
        if not self.isStarted or self.inspired == prev:
            return
        data = self.inspired
        equipmentComp = self._getEquipmentComp()
        if equipmentComp is not None:
            if data is not None:
                equipmentComp.updateInspired(self.id, data.startTime, data.endTime, data.inactivationStartTime, data.inactivationEndTime, data.primary, data.equipmentID, data.inactivationSource)
            else:
                equipmentComp.updateInspired(self.id, None, None, None, None, None, None, None)
        return

    def set_healingEffect(self, prev=None):
        if not self.isStarted or self.healingEffect == prev:
            return
        data = self.healingEffect
        equipmentComp = self._getEquipmentComp()
        if equipmentComp is not None:
            if data is not None:
                radius = data.radius if data.radius > 0 else None
                equipmentComp.updateHealingSource(self.id, data.startTime, data.endTime, data.inactivationDelay, radius)
            else:
                equipmentComp.updateHealingSource(self.id, None, None, None, None)
        return

    def set_healing(self, prev=None):
        if not self.isStarted or self.healing == prev:
            return
        data = self.healing
        equipmentComp = self._getEquipmentComp()
        if equipmentComp is not None:
            if data is not None:
                equipmentComp.updateHealing(self.id, data.senderKey, data.startTime, data.endTime, data.inactivationStartTime, data.inactivationEndTime)
            else:
                equipmentComp.updateHealing(self.id, None, None, None, None, None)
        return

    def set_healOverTime(self, prev=None):
        if not self.isStarted or self.healOverTime == prev:
            return
        data = self.healOverTime
        equipmentComp = self._getEquipmentComp()
        if equipmentComp is not None:
            if data is not None:
                equipmentComp.updateHealOverTime(self.id, data.senderKey, data.startTime, data.endTime, data.inactivationStartTime, data.inactivationEndTime, data.isInfluenceZone)
            else:
                equipmentComp.updateHealOverTime(self.id, None, None, None, None, None, False)
        return

    def set_debuff(self, prev=None):
        if not self.isStarted or self.debuff == prev:
            return
        isInfluenceZone = self.debuff
        equipmentComp = self._getEquipmentComp()
        if equipmentComp is not None:
            equipmentComp.updateDebuff(self.id, isInfluenceZone)
        return

    def _removeInspire(self):
        if self.inspired or self.inspiringEffect:
            equipmentComp = self._getEquipmentComp()
            if equipmentComp is not None:
                equipmentComp.removeInspire(self.id)
        return

    def _removeHealing(self):
        if self.healing or self.healingEffect:
            equipmentComp = self._getEquipmentComp()
            if equipmentComp is not None:
                equipmentComp.removeHealPoint(self.id)
        return

    def _removeHealOverTime(self):
        if self.healOverTime():
            equipmentComp = self._getEquipmentComp()
            if equipmentComp is not None:
                equipmentComp.removeRepairPoint(self.id)
        return