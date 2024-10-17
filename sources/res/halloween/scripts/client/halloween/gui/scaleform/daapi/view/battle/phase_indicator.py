from typing import Optional
from HWArenaPhasesComponent import HWArenaPhasesComponent
from gui.impl import backport
from halloween.gui.scaleform.daapi.view.meta.PhaseIndicatorMeta import PhaseIndicatorMeta
from halloween_common.halloween_constants import ARENA_GUI_TYPE
from helpers import dependency
from gui.impl.gen import R
from skeletons.gui.battle_session import IBattleSessionProvider
_R_INDICATOR = R.strings.halloween_battle.arena
_PHASE = 'phase'
_WAVE = 'wave'

class HWPhaseIndicator(PhaseIndicatorMeta):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def _populate(self):
        super(HWPhaseIndicator, self)._populate()
        HWArenaPhasesComponent.onPhaseChanged += self._update

    def _dispose(self):
        HWArenaPhasesComponent.onPhaseChanged -= self._update
        super(HWPhaseIndicator, self)._dispose()

    def _update(self, arenaPhases):
        if not arenaPhases:
            return
        self.__updateProgressInfo(arenaPhases.activePhase, arenaPhases.phasesCount)

    def __updateProgressInfo(self, activePhase, phasesCount):
        isDefenceMode = self.sessionProvider.arenaVisitor.getArenaGuiType() == ARENA_GUI_TYPE.HALLOWEEN_DEFENCE
        progressInfo = backport.text(_R_INDICATOR.dyn(_PHASE if not isDefenceMode else _WAVE)(), current=activePhase, total=phasesCount)
        self.as_setDataS(progressInfo)