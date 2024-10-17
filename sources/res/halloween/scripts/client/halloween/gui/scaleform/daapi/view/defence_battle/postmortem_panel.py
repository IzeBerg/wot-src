from gui.impl.gen import R
from halloween.gui.scaleform.daapi.view.battle.postmortem_panel import HWPostmortemPanel

class HWDefPostmortemPanel(HWPostmortemPanel):
    DEFENCE_DEATH_REASON_TIMEOUT = 'DEF_DEATH_FROM_PHASE_TIMER_SELF_SUICIDE_LATE'
    RESPAWN_INFO = R.strings.halloween_battle.postmortemPanel.doNotLeaveGame.defence.desc()

    def _prepareMessage(self, code, killerVehID, device=None):
        if code == self.PHASE_DEATH_REASON:
            code = self.DEFENCE_DEATH_REASON_TIMEOUT
        super(HWDefPostmortemPanel, self)._prepareMessage(code, killerVehID, device)