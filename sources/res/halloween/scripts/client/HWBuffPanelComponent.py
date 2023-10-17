from dyn_components_groups import groupComponent
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from skeletons.gui.battle_session import IBattleSessionProvider
from xml_config_specs import StrParam, ListParam, ObjParam, FloatParam

@groupComponent(buffKey=StrParam(), params=ListParam(valueParam=ObjParam(key=StrParam(), value=FloatParam())))
class HWBuffPanelComponent(DynamicScriptComponent):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWBuffPanelComponent, self).__init__()
        self._buffKey = self.groupComponentConfig.buffKey
        self._params = self.groupComponentConfig.params

    @property
    def buffKey(self):
        return self._buffKey

    @property
    def params(self):
        return self._params

    def _onAvatarReady(self):
        super(HWBuffPanelComponent, self)._onAvatarReady()
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            ctx = {'buffKey': self._buffKey, 'params': self._params, 
               'vehicleID': self.entity.id}
            hwBattleGuiCtrl.applyBuff(ctx)

    def onDestroy(self):
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.unapplyBuff({'buffKey': self._buffKey, 
               'vehicleID': self.entity.id})
        super(HWBuffPanelComponent, self).onDestroy()