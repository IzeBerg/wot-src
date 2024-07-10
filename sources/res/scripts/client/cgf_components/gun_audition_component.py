import CGF
from cgf_script.managers_registrator import autoregister, onAddedQuery
from vehicle_systems.cgf_helpers import getVehicleEntityByGameObject
from Vehicular import GunAudition

@autoregister(presentInAllWorlds=True)
class GunAuditionsManager(CGF.ComponentManager):

    @onAddedQuery(CGF.GameObject, GunAudition, tickGroup='preInitGroup')
    def onGunAuditionAdded(self, gameObject, gunAudition):
        vehicle = getVehicleEntityByGameObject(gameObject)
        if vehicle is not None:
            gunAudition.isPlayer = vehicle.isPlayerVehicle
        return