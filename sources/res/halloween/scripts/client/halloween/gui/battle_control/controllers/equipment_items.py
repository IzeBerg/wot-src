import BigWorld
from DynComponentsGroup import DynComponentsGroup
from HWBuffDrainLifeComponent import HWBuffDrainLifeComponent
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.shared.system_factory import registerEquipmentItem
from gui.battle_control import avatar_getter, vehicle_getter
from gui.battle_control.controllers.consumables.equipment_ctrl import _ActivationError, DynComponentsGroupItem, DynComponentsGroupReplayItem
from gui.battle_control.battle_constants import DEVICE_STATE_DESTROYED
from constants import SERVER_TICK_LENGTH

class HWEquipmentItem(DynComponentsGroupItem):

    def canActivate(self, entityName=None, avatar=None):
        vehicle = BigWorld.entities.get(avatar_getter.getPlayerVehicleID())
        result, error = super(HWEquipmentItem, self).canActivate(entityName, avatar)
        if not result:
            return (result, error)
        if vehicle.hwSoulsContainer.souls < self._descriptor.getVariant(vehicle.typeDescriptor).usageCost:
            return (False, _ActivationError('hwNotEnoughSouls', {'name': self._descriptor.userString}))
        return (result, error)


class HWEquipmentReplayItem(DynComponentsGroupReplayItem):

    def canActivate(self, entityName=None, avatar=None):
        vehicle = BigWorld.entities.get(avatar_getter.getPlayerVehicleID())
        result, error = super(HWEquipmentReplayItem, self).canActivate(entityName, avatar)
        if not result:
            return (result, error)
        if vehicle.hwSoulsContainer.souls < self._descriptor.getVariant(vehicle.typeDescriptor).usageCost:
            return (False, _ActivationError('hwNotEnoughSouls', {'name': self._descriptor.userString}))
        return (result, error)


class _HpRepairAndCrewHeal(HWEquipmentItem):

    def canActivate(self, entityName=None, avatar=None):
        vehicle = BigWorld.entities.get(avatar_getter.getPlayerVehicleID())
        deviceStates = avatar_getter.getVehicleDeviceStates(avatar)
        if vehicle.health >= vehicle.maxHealth and not deviceStates and not avatar_getter.isVehicleStunned():
            return (False, _ActivationError('hpRepairAndCrewHeal', {'name': self._descriptor.userString}))
        return super(_HpRepairAndCrewHeal, self).canActivate(entityName, avatar)


class _AbilityWithDuration(HWEquipmentItem):

    def canActivate(self, entityName=None, avatar=None):
        avatar = avatar or BigWorld.player()
        vehicle = BigWorld.entities.get(avatar.playerVehicleID)
        if not vehicle:
            return (False, _ActivationError('equipmentAlreadyActivated', {'name': self._descriptor.userString}))
        hasActiveBuff = any(isinstance(g, DynComponentsGroup) and name in self._descriptor.dynComponentsGroups for name, g in vehicle.dynamicComponents.iteritems())
        if hasActiveBuff:
            return (False, _ActivationError('equipmentAlreadyActivated', {'name': self._descriptor.userString}))
        return super(_AbilityWithDuration, self).canActivate(entityName, avatar)


class _NitroEquipmentItem(_AbilityWithDuration):

    def inCriticalCondition(self, avatar=None):
        avatar = avatar or BigWorld.player()
        if avatar.fireInVehicle:
            return (True, _ActivationError('hwVehicleIsOnFire', {'name': self._descriptor.userString}))
        else:
            if avatar.isVehicleOverturned:
                return (True, _ActivationError('hwVehicleIsOverturned', {'name': self._descriptor.userString}))
            if avatar.isVehicleDrowning:
                return (True, _ActivationError('hwVehicleIsDrowning', {'name': self._descriptor.userString}))
            return (False, None)

    def canActivate(self, entityName=None, avatar=None):
        inCritical, error = self.inCriticalCondition(avatar)
        if inCritical:
            return (False, error)
        return super(_NitroEquipmentItem, self).canActivate(entityName, avatar)


class _NitroEquipmentReplayItem(DynComponentsGroupReplayItem):

    def inCriticalCondition(self, avatar=None):
        avatar = avatar or BigWorld.player()
        if avatar.fireInVehicle:
            return (True, _ActivationError('hwVehicleIsOnFire', {'name': self._descriptor.userString}))
        else:
            if avatar.isVehicleOverturned:
                return (True, _ActivationError('hwVehicleIsOverturned', {'name': self._descriptor.userString}))
            if avatar.isVehicleDrowning:
                return (True, _ActivationError('hwVehicleIsDrowning', {'name': self._descriptor.userString}))
            return (False, None)


class _FastReload(_AbilityWithDuration):
    INSTANT_RELOAD = 'instantReload'
    DEVICES = ('gun', )
    ERROR_NAME = 'hw_ability_gun_destroyed'
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def getEntitiesIterator(self, avatar=None):
        return vehicle_getter.VehicleDeviceStatesIterator(avatar_getter.getVehicleDeviceStates(avatar), avatar_getter.getVehicleTypeDescriptor(avatar))

    def canActivate(self, entityName=None, avatar=None):
        vehicle = BigWorld.entities.get(avatar_getter.getPlayerVehicleID())
        if self._descriptor.getVariant(vehicle.typeDescriptor).equipmentItem == self.INSTANT_RELOAD:
            return self._canActivateInstant(entityName, avatar)
        return self._canActivateFast(entityName, avatar)

    def _canActivateFast(self, entityName=None, avatar=None):
        isGunDestroyed = any(name in self.DEVICES and state == DEVICE_STATE_DESTROYED for name, state in self.getEntitiesIterator())
        if isGunDestroyed:
            return (False,
             _ActivationError(self.ERROR_NAME, {'name': self._descriptor.userString}))
        return super(_FastReload, self).canActivate(entityName, avatar)

    def _canActivateInstant(self, entityName=None, avatar=None):
        avatar = avatar or BigWorld.player()
        result, error = super(_FastReload, self).canActivate(entityName, avatar)
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


class _HWInvisibility(HWEquipmentItem):

    def canActivate(self, entityName=None, avatar=None):
        vehicle = BigWorld.entities.get(avatar_getter.getPlayerVehicleID())
        hasActiveBuff = any(isinstance(component, HWBuffDrainLifeComponent) and component.isActive for component in vehicle.dynamicComponents.itervalues())
        if avatar_getter.isVehicleInFire(avatar) or hasActiveBuff:
            return (False, _ActivationError('hwInvisibility', {'name': self._descriptor.userString}))
        return super(_HWInvisibility, self).canActivate(entityName, avatar)


class _HWInstantShot(HWEquipmentItem):

    def activate(self, entityName=None, avatar=None):
        BigWorld.player().startWaitingForShot(SERVER_TICK_LENGTH * 2.0)
        super(_HWInstantShot, self).activate(entityName, avatar)


def registerHWEquipmentsItems():
    registerEquipmentItem('nitroRamDamage', _NitroEquipmentItem, _NitroEquipmentReplayItem)
    registerEquipmentItem('hpRepairAndCrewHeal', _HpRepairAndCrewHeal, HWEquipmentReplayItem)
    registerEquipmentItem('teamRepairKit', HWEquipmentItem, HWEquipmentReplayItem)
    registerEquipmentItem('fastReload', _FastReload, HWEquipmentReplayItem)
    registerEquipmentItem('damageShield', _AbilityWithDuration, HWEquipmentReplayItem)
    registerEquipmentItem('hwInvisibility', _HWInvisibility, HWEquipmentReplayItem)
    registerEquipmentItem('hwAoeDamageInstantShot', _HWInstantShot, HWEquipmentReplayItem)
    registerEquipmentItem('hwAoeStunInstantShot', _HWInstantShot, HWEquipmentReplayItem)
    registerEquipmentItem('hwAoeDrainEnemyHpInstantShot', _HWInstantShot, HWEquipmentReplayItem)
    registerEquipmentItem('hpRepairAndCrewHealDefence', _HpRepairAndCrewHeal, HWEquipmentReplayItem)
    registerEquipmentItem('teamRepairKitDefence', HWEquipmentItem, HWEquipmentReplayItem)
    registerEquipmentItem('damageShieldDefence', _AbilityWithDuration, HWEquipmentReplayItem)
    registerEquipmentItem('fastReloadDefence', _FastReload, HWEquipmentReplayItem)
    registerEquipmentItem('hwAoeDamageInstantShotDefence', _HWInstantShot, HWEquipmentReplayItem)
    registerEquipmentItem('hwAoeStunInstantShotDefence', _HWInstantShot, HWEquipmentReplayItem)
    registerEquipmentItem('hwAoeDrainEnemyHpInstantShotDefence', _HWInstantShot, HWEquipmentReplayItem)
    registerEquipmentItem('hwInvisibilityDefence', _HWInvisibility, HWEquipmentReplayItem)