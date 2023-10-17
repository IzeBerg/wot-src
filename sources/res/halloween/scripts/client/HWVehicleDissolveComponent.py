import BigWorld
from script_component.DynamicScriptComponent import DynamicScriptComponent
from vehicle_systems.tankStructure import VehiclePartsTuple, TankPartNames
from helpers.CallbackDelayer import CallbackDelayer
from skeletons.gui.battle_session import IBattleSessionProvider
from helpers import dependency
_DISSOLVE_TIME_TICK = 0.05
_DISSOLVE_FACTOR_STEP = 0.015
_DISSOLVE_FULL_FACTOR = 1.0

class HWVehicleDissolveComponent(DynamicScriptComponent):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWVehicleDissolveComponent, self).__init__()
        self.__callbackDelayer = CallbackDelayer()
        self.__dissolveHandler = None
        return

    def onDestroy(self):
        self.entity.onAppearanceReady -= self.__onAppearanceReady
        if self.entity.appearance:
            self.entity.appearance.onModelChanged -= self.__onModelChanged
        self.__callbackDelayer.destroy()
        super(HWVehicleDissolveComponent, self).onDestroy()

    def _onAvatarReady(self):
        appearance = self.entity.appearance
        self.entity.onAppearanceReady += self.__onAppearanceReady
        if appearance is not None:
            if appearance.isAlive:
                self.__onAppearanceReady()
            else:
                self.__onModelChanged()
        super(HWVehicleDissolveComponent, self)._onAvatarReady()
        return

    def __onAppearanceReady(self):
        self.__dissolveHandler = None
        self.__callbackDelayer.clearCallbacks()
        self.entity.appearance.onModelChanged += self.__onModelChanged
        return

    def __onModelChanged(self):
        vehicle = self.entity
        if vehicle.isDestroyed or vehicle.health > 0:
            return
        appearance = vehicle.appearance
        if not appearance.damageState.isCurrentModelDamaged:
            return
        fashions = VehiclePartsTuple(BigWorld.WGVehicleFashion(), BigWorld.WGVehicleFashion(), BigWorld.WGVehicleFashion(), BigWorld.WGVehicleFashion())
        appearance._setFashions(fashions, appearance.isTurretDetached)
        self.__dissolveHandler = BigWorld.PyDissolveHandler()
        for fashionIdx, _ in enumerate(TankPartNames.ALL):
            fashion = appearance.fashions[fashionIdx]
            fashion.addMaterialHandler(self.__dissolveHandler)
            fashion.addTrackMaterialHandler(self.__dissolveHandler)

        self.__dissolveHandler.setEnabled(True)
        self.__dissolve(0.0)

    def __dissolve(self, factor):
        factor += _DISSOLVE_FACTOR_STEP
        self.__dissolveHandler.setDissolveFactor(factor)
        if factor < _DISSOLVE_FULL_FACTOR:
            self.__callbackDelayer.delayCallback(_DISSOLVE_TIME_TICK, self.__dissolve, factor)
        else:
            self.__hideModel()
            for fashionIdx, _ in enumerate(TankPartNames.ALL):
                self.entity.appearance.fashions[fashionIdx].removeMaterialHandler(self.__dissolveHandler)

            self.__dissolveHandler = None
        return

    def __hideModel(self):
        self.entity.show(False)
        self.entity.appearance.boundEffects.stop()
        self.guiSessionProvider.shared.feedback.onVehicleMarkerRemoved(self.entity.id)