import typing, CGF
from constants import IS_CLIENT
from cgf_script.managers_registrator import autoregister, onAddedQuery, onRemovedQuery
from Vehicular import GunEffectsController
from vehicle_systems.cgf_helpers import getVehicleEntityComponentByGameObject
if IS_CLIENT:
    from TwinGunController import TwinGunController
else:

    class TwinGunController(object):
        pass


if typing.TYPE_CHECKING:
    from vehicle_systems.twin_guns.system_interfaces import ITwinGunShootingEvents

@autoregister(presentInAllWorlds=True)
class TwinGunManager(CGF.ComponentManager):

    @onAddedQuery(CGF.GameObject, GunEffectsController, tickGroup='PreSimulation')
    def onGunEffectsControllerAdded(self, gameObject, gunEffectsController):
        ctrl = getVehicleEntityComponentByGameObject(gameObject, TwinGunController)
        if ctrl is not None and ctrl.shootingEvents is not None:
            events = ctrl.shootingEvents
            events.onDiscreteShot += gunEffectsController.singleShot
            events.onDoubleShot += gunEffectsController.multiShot
        return

    @onRemovedQuery(CGF.GameObject, GunEffectsController)
    def onGunEffectsControllerRemoved(self, gameObject, gunEffectsController):
        ctrl = getVehicleEntityComponentByGameObject(gameObject, TwinGunController)
        if ctrl is not None and ctrl.shootingEvents is not None:
            events = ctrl.shootingEvents
            events.onDoubleShot -= gunEffectsController.multiShot
            events.onDiscreteShot -= gunEffectsController.singleShot
        return