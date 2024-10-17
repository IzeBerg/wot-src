import typing
from helpers import dependency
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from script_component.DynamicScriptComponent import DynamicScriptComponent
from skeletons.gui.battle_session import IBattleSessionProvider

class HWWaveProgressDefenceComponent(DynamicScriptComponent):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    @property
    def hwBattleGuiCtrl(self):
        return self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    def _onAvatarReady(self):
        super(HWWaveProgressDefenceComponent, self)._onAvatarReady()
        if self.hwBattleGuiCtrl is not None:
            self.hwBattleGuiCtrl.updateEnemiesInfo(dict(self.enemiesInfo))
            self.hwBattleGuiCtrl.updateHealthBreakpoints(self.healthBreakpoints)
            self.hwBattleGuiCtrl.updateEnemiesStatus(self.enemiesStatus)
        return

    def set_enemiesInfo(self, prev):
        if self.hwBattleGuiCtrl is not None:
            self.hwBattleGuiCtrl.updateEnemiesInfo(dict(self.enemiesInfo))
        return

    def set_healthBreakpoints(self, prev):
        if self.hwBattleGuiCtrl is not None:
            self.hwBattleGuiCtrl.updateHealthBreakpoints(self.healthBreakpoints)
        return

    def set_enemiesStatus(self, prev):
        if self.hwBattleGuiCtrl is not None:
            self.hwBattleGuiCtrl.updateEnemiesStatus(self.enemiesStatus)
        return