import weakref, random, BigWorld
from visual_script.block import Block, EDITOR_TYPE, InitParam, buildStrKeysValue
from visual_script.slot_types import SLOT_TYPE
from visual_script.misc import ASPECT, errorVScript
from visual_script.tunable_event_block import TunableEventBlock
from visual_script.vehicle_blocks import VehicleMeta

class GetVehicleLabel(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(GetVehicleLabel, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._label = self._makeDataOutputSlot('label', SLOT_TYPE.STR, self._getLabel)

    def _getLabel(self):
        label = self._vehicle.getValue().label
        if label is None:
            label = ''
        self._label.setValue(label)
        return

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT]


class OnAnyVehicleDestroyed(TunableEventBlock, VehicleMeta):
    _EVENT_SLOT_NAMES = [
     'onDestroyed']

    def __init__(self, *args, **kwargs):
        super(OnAnyVehicleDestroyed, self).__init__(*args, **kwargs)
        self._target = self._makeDataOutputSlot('target', SLOT_TYPE.VEHICLE, None)
        self._attacker = self._makeDataOutputSlot('attacker', SLOT_TYPE.VEHICLE, None)
        return

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/arena_event'

    def onStartScript(self):
        if hasattr(BigWorld.player(), 'arena'):
            BigWorld.player().arena.onVehicleKilled += self.__onVehicleKilled
        else:
            errorVScript(self, 'can not subscribe on event')

    def onFinishScript(self):
        BigWorld.player().arena.onVehicleKilled -= self.__onVehicleKilled

    @TunableEventBlock.eventProcessor
    def __onVehicleKilled(self, targetID, attackerID, equipmentID, reason, numVehiclesAffected):
        target = BigWorld.entities.get(targetID)
        if target:
            self._target.setValue(weakref.proxy(BigWorld.entities.get(targetID)))
        else:
            self._target.setValue(None)
        if attackerID > 0:
            attacker = BigWorld.entities.get(attackerID)
            if attacker:
                attacker = weakref.proxy(BigWorld.entities.get(attackerID))
                self._attacker.setValue(attacker)
            else:
                self._attacker.setValue(None)
        else:
            self._attacker.setValue(None)
        return

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT]


class OnAnyVehicleDamaged(TunableEventBlock, VehicleMeta):
    _EVENT_SLOT_NAMES = [
     'onDamaged']

    def __init__(self, *args, **kwargs):
        super(OnAnyVehicleDamaged, self).__init__(*args, **kwargs)
        self._target = self._makeDataOutputSlot('target', SLOT_TYPE.VEHICLE, None)
        self._attacker = self._makeDataOutputSlot('attacker', SLOT_TYPE.VEHICLE, None)
        self._damage = self._makeDataOutputSlot('damage', SLOT_TYPE.INT, None)
        return

    @classmethod
    def blockIcon(cls):
        return ':vse/blocks/arena_event'

    def onStartScript(self):
        if hasattr(BigWorld.player(), 'arena'):
            BigWorld.player().arena.onVehicleHealthChanged += self.__onDamageReceived
        else:
            errorVScript(self, 'can not subscribe on event')

    def onFinishScript(self):
        BigWorld.player().arena.onVehicleHealthChanged -= self.__onDamageReceived

    @TunableEventBlock.eventProcessor
    def __onDamageReceived(self, vehicleId, attackerId, damage):
        self._damage.setValue(damage)
        vehicle = BigWorld.entities.get(vehicleId)
        if vehicle:
            self._target.setValue(weakref.proxy(vehicle))
        else:
            self._damage.setValue(None)
            self._target.setValue(None)
        if attackerId > 0:
            attacker = BigWorld.entities.get(attackerId)
            if attacker:
                attacker = weakref.proxy(BigWorld.entities.get(attackerId))
                self._attacker.setValue(attacker)
            else:
                self._attacker.setValue(None)
        else:
            self._attacker.setValue(None)
        return

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT]


class IsVehicleBurning(Block, VehicleMeta):

    def __init__(self, *args, **kwargs):
        super(IsVehicleBurning, self).__init__(*args, **kwargs)
        self._vehicle = self._makeDataInputSlot('vehicle', SLOT_TYPE.VEHICLE)
        self._res = self._makeDataOutputSlot('res', SLOT_TYPE.BOOL, self._exec)

    def _exec(self):
        v = self._vehicle.getValue()
        self._res.setValue(v.isOnFire())

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT]


class GetNearestAliveVehicle(Block, VehicleMeta):
    _settingTypes = [
     'Ally', 'Enemy', 'Any']

    @classmethod
    def initParams(cls):
        return [
         InitParam('Vehicle Team', SLOT_TYPE.STR, buildStrKeysValue(*cls._settingTypes), EDITOR_TYPE.STR_KEY_SELECTOR)]

    def __init__(self, *args, **kwargs):
        super(GetNearestAliveVehicle, self).__init__(*args, **kwargs)
        self._settingType, = self._getInitParams()
        self._position = self._makeDataInputSlot('position', SLOT_TYPE.VECTOR3)
        self._vehicle = self._makeDataOutputSlot('vehicle', SLOT_TYPE.VEHICLE, self._execute)

    def __checkVehicle(self, vehicle):
        player = BigWorld.player()
        if not hasattr(vehicle, 'isStarted') or not vehicle.isStarted or not vehicle.isAlive():
            return False
        if player.vehicle and vehicle.id == player.vehicle.id:
            return False
        if self._settingType == 'Ally':
            return vehicle.publicInfo.team == player.team
        if self._settingType == 'Enemy':
            return vehicle.publicInfo.team != player.team
        return True

    def _execute(self):
        player = BigWorld.player()
        vehicles = (v for v in player.vehicles if self.__checkVehicle(v))
        vehicle = None
        minDist = 99999
        for v in vehicles:
            dist = player.vehicle.position.distTo(v.position)
            if dist < minDist:
                vehicle = v
                minDist = dist

        self._vehicle.setValue(weakref.proxy(vehicle) if vehicle else None)
        return

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT]


class GetAnyVehicle(Block, VehicleMeta):
    _settingTypes = [
     'Ally', 'Enemy', 'Any']

    @classmethod
    def initParams(cls):
        return [
         InitParam('Vehicle Team', SLOT_TYPE.STR, buildStrKeysValue(*cls._settingTypes), EDITOR_TYPE.STR_KEY_SELECTOR)]

    def __init__(self, *args, **kwargs):
        super(GetAnyVehicle, self).__init__(*args, **kwargs)
        self._settingType, = self._getInitParams()
        self._vehicle = self._makeDataOutputSlot('vehicle', SLOT_TYPE.VEHICLE, self._execute)

    def __checkVehicle(self, vehicle):
        player = BigWorld.player()
        if not hasattr(vehicle, 'isStarted') or not vehicle.isStarted or not vehicle.isAlive():
            return False
        if player.vehicle and vehicle.id == player.vehicle.id:
            return False
        if self._settingType == 'Ally':
            return vehicle.publicInfo.team == player.team
        if self._settingType == 'Enemy':
            return vehicle.publicInfo.team != player.team
        return True

    def _execute(self):
        player = BigWorld.player()
        vehicles = [ v for v in player.vehicles if self.__checkVehicle(v) ]
        vehicle = random.choice(vehicles) if vehicles else None
        self._vehicle.setValue(weakref.proxy(vehicle) if vehicle else None)
        return

    @classmethod
    def blockAspects(cls):
        return [ASPECT.CLIENT]