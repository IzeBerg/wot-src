import BigWorld
from DynComponentsGroup import DynComponentsGroup
from HWBuffDrainLifeComponent import HWBuffDrainLifeComponent
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.shared.system_factory import registerEquipmentItem
from gui.battle_control import avatar_getter, vehicle_getter
from gui.battle_control.controllers.consumables.equipment_ctrl import _ActivationError, DynComponentsGroupItem, DynComponentsGroupReplayItem
from gui.battle_control.battle_constants import DEVICE_STATE_DESTROYED

class _HpRepairAndCrewHeal(DynComponentsGroupItem):

    def canActivate(self, entityName=None, avatar=None):
        vehicle = BigWorld.entities.get(avatar_getter.getPlayerVehicleID())
        deviceStates = avatar_getter.getVehicleDeviceStates(avatar)
        if vehicle.health >= vehicle.maxHealth and not deviceStates:
            return (False, _ActivationError('hpRepairAndCrewHeal', {'name': self._descriptor.userString}))
        return super(_HpRepairAndCrewHeal, self).canActivate(entityName, avatar)


class _AbilityWithDuration(DynComponentsGroupItem):

    def canActivate(self, entityName=None, avatar=None):
        avatar = avatar or BigWorld.player()
        vehicle = BigWorld.entities.get(avatar.playerVehicleID)
        if not vehicle:
            return (False, _ActivationError('equipmentAlreadyActivated', {'name': self._descriptor.userString}))
        hasActiveBuff = any(isinstance(g, DynComponentsGroup) and name in self._descriptor.dynComponentsGroups for name, g in vehicle.dynamicComponents.iteritems())
        if hasActiveBuff:
            return (False, _ActivationError('equipmentAlreadyActivated', {'name': self._descriptor.userString}))
        return super(_AbilityWithDuration, self).canActivate(entityName, avatar)


class _InstantReload(DynComponentsGroupItem):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def canActivate(self, entityName=None, avatar=None):
        avatar = avatar or BigWorld.player()
        result, error = super(_InstantReload, self).canActivate(entityName, avatar)
        if not result:
            return (result, error)
        else:
            ammoCtrl = self.guiSessionProvider.shared.ammo
            quantity, quantityInClip = ammoCtrl.getCurrentShells()
            if not quantity:
                return (False, None)
            isGunReloading = ammoCtrl.isGunReloading()
            if isGunReloading:
                return (True, None)
            if ammoCtrl.getGunSettings().isDualGun:
                reloadingState = ammoCtrl.getGunReloadingState()
                dualGunShellChangeTime = ammoCtrl.getDualGunShellChangeTime()
                if reloadingState.getBaseValue() >= min(dualGunShellChangeTime.left, dualGunShellChangeTime.right):
                    return (True, None)
            if ammoCtrl.getGunSettings().isCassetteClip():
                clipCapacity = ammoCtrl.getGunSettings().clip.size
                if quantityInClip >= quantity:
                    return (False, None)
                if clipCapacity > quantityInClip:
                    return (True, None)
            return (
             False,
             _ActivationError('instantReload', {'name': self._descriptor.userString}))


class _FastReload(_AbilityWithDuration):
    DEVICES = ('gun', )
    ERROR_NAME = 'hw_ability_gun_destroyed'

    def getEntitiesIterator(self, avatar=None):
        return vehicle_getter.VehicleDeviceStatesIterator(avatar_getter.getVehicleDeviceStates(avatar), avatar_getter.getVehicleTypeDescriptor(avatar))

    def canActivate(self, entityName=None, avatar=None):
        isGunDestroyed = any(name in self.DEVICES and state == DEVICE_STATE_DESTROYED for name, state in self.getEntitiesIterator())
        if isGunDestroyed:
            return (False,
             _ActivationError(self.ERROR_NAME, {'name': self._descriptor.userString}))
        return super(_FastReload, self).canActivate(entityName, avatar)


class _HWInvisibility(DynComponentsGroupItem):

    def canActivate(self, entityName=None, avatar=None):
        vehicle = BigWorld.entities.get(avatar_getter.getPlayerVehicleID())
        hasActiveBuff = any(isinstance(component, HWBuffDrainLifeComponent) and component.isActive for component in vehicle.dynamicComponents.itervalues())
        if avatar_getter.isVehicleInFire(avatar) or hasActiveBuff:
            return (False, _ActivationError('hwInvisibility', {'name': self._descriptor.userString}))
        return super(_HWInvisibility, self).canActivate(entityName, avatar)


def registerHWEquipmentsItems():
    registerEquipmentItem('hpRepairAndCrewHeal', _HpRepairAndCrewHeal, DynComponentsGroupReplayItem)
    registerEquipmentItem('damageShield', _AbilityWithDuration, DynComponentsGroupReplayItem)
    registerEquipmentItem('instantReload', _InstantReload, DynComponentsGroupReplayItem)
    registerEquipmentItem('fastReload', _FastReload, DynComponentsGroupReplayItem)
    registerEquipmentItem('hwInvisibility', _HWInvisibility, DynComponentsGroupReplayItem)