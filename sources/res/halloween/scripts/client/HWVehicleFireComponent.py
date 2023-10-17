import BigWorld, random
from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE

class HWVehicleFireComponent(DynamicScriptComponent):
    __guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWVehicleFireComponent, self).__init__()
        self.__effectsPlayer = None
        return

    def onDestroy(self):
        self.__stopEffect()

    def _onAvatarReady(self):
        self.__playEffect()

    def __playEffect(self):
        vehicle = self.entity
        stages, effects, _ = random.choice(vehicle.typeDescriptor.type.effects['flaming'])
        effectListPlayer = vehicle.appearance.boundEffects.addNew(None, effects, stages, True)
        self.__effectsPlayer = effectListPlayer
        player = BigWorld.player()
        if player and player.vehicle and player.vehicle.id == vehicle.id:
            self.__guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.FIRE, True)
        return

    def __stopEffect(self):
        player = BigWorld.player()
        if player and player.vehicle and player.vehicle.id == self.entity.id and not player.vehicle.isOnFire():
            self.__guiSessionProvider.shared.messages.showVehicleMessage('FIRE_STOPPED')
            self.__guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.FIRE, False)
        if self.__effectsPlayer is None:
            return
        else:
            self.__effectsPlayer.stop(forceCallback=True)
            return