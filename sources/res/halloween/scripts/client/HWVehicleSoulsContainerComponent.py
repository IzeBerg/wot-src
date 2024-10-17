import BigWorld, Event
from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from skeletons.gui.battle_session import IBattleSessionProvider

class HWVehicleSoulsContainerComponent(DynamicScriptComponent):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWVehicleSoulsContainerComponent, self).__init__()
        self.onChangeSoulsCount = Event.Event()

    def _onAvatarReady(self):
        super(HWVehicleSoulsContainerComponent, self)._onAvatarReady()
        from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl and self.entity.id == BigWorld.player().playerVehicleID:
            hwBattleGuiCtrl.onSoulsContainerReady(self)

    def set_lastCollected(self, _):
        _, reason = self.lastCollected
        self.onChangeSoulsCount(self.souls, reason)

    def onDestroy(self):
        self.onChangeSoulsCount.clear()
        super(HWVehicleSoulsContainerComponent, self).onDestroy()