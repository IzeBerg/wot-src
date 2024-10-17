from dyn_components_groups import groupComponent
from script_component.DynamicScriptComponent import DynamicScriptComponent
from xml_config_specs import StrParam
from skeletons.gui.battle_session import IBattleSessionProvider
from helpers import dependency
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID

@groupComponent(icon=StrParam())
class HWBuffVehicleIconComponent(DynamicScriptComponent):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWBuffVehicleIconComponent, self).__init__()
        self._icon = self.groupComponentConfig.icon

    def _onAvatarReady(self):
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.addVehicleMarkerIcon(self.entity.id, self._icon)

    def onDestroy(self):
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.removeVehicleMarkerIcon(self.entity.id, self._icon)
        super(HWBuffVehicleIconComponent, self).onDestroy()

    @property
    def icon(self):
        return self._icon