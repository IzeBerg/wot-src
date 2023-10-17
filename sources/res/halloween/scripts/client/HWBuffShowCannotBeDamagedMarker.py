import BigWorld
from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from HWArenaInfoBossHealthBarComponent import getArenaInfoBossHealthBarComponent
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID as _FET
from halloween_common.halloween_constants import BOSS_ROLE_TAG

def isInvulnerableBoss(vehicleID):
    component = getArenaInfoBossHealthBarComponent()
    if component is None or component.isActive:
        return False
    vehicle = BigWorld.entities.get(vehicleID)
    if vehicle is None:
        return False
    else:
        return BOSS_ROLE_TAG in vehicle.typeDescriptor.type.tags


class HWBuffShowCannotBeDamagedMarker(DynamicScriptComponent):
    _guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def _onAvatarReady(self):
        super(HWBuffShowCannotBeDamagedMarker, self)._onAvatarReady()
        isInvulnerable = isInvulnerableBoss(self.entity.id)
        feedback = self._guiSessionProvider.shared.feedback
        if isInvulnerable and feedback:
            feedback.setVehicleState(self.entity.id, _FET.VEHICLE_HIT)