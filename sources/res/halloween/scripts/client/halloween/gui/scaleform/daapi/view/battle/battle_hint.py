import BattleReplay
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from halloween.gui.scaleform.daapi.view.meta.BattleHintMeta import BattleHintMeta
from gui.battle_control.controllers.battle_hints_ctrl import BattleHintComponent
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class HWHintParams(object):
    __slots__ = ('yOffset', 'isAdaptive')

    def __init__(self, section):
        super(HWHintParams, self).__init__()
        self.yOffset = section.readInt('yOffset', 0)
        self.isAdaptive = section.readBool('isAdaptive', False)

    def updateVO(self, hintVO):
        hintVO.update({'extraPadding': self.yOffset, 
           'isAdaptive': self.isAdaptive})


class BattleHint(BattleHintComponent, BattleHintMeta):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def _populate(self):
        super(BattleHint, self)._populate()
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBattleGoalChanged += self._onBattleGoalChanged

    def _dispose(self):
        super(BattleHint, self)._dispose()
        hwBattleGuiCtrl = self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBattleGoalChanged -= self._onBattleGoalChanged
        if BattleReplay.g_replayCtrl.isPlaying:
            self._hideHint()

    def _showHint(self, hint, data):
        hintVO = hint.makeVO(data)
        if hint.hintParams:
            hint.hintParams.updateVO(hintVO)
        self.as_showHintS(hintVO)

    def _hideHint(self):
        self.as_hideHintS()

    def _onBattleGoalChanged(self, goalName):
        if goalName is None:
            self.as_clearPinnableHintS()
        return