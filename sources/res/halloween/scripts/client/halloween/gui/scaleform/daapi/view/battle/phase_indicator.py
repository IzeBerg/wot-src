from typing import Optional
from HWArenaPhasesComponent import HWArenaPhasesComponent
from halloween.gui.scaleform.daapi.view.meta.PhaseIndicatorMeta import PhaseIndicatorMeta

class HWPhaseIndicator(PhaseIndicatorMeta):

    def _populate(self):
        super(HWPhaseIndicator, self)._populate()
        HWArenaPhasesComponent.onPhaseChanged += self._update

    def _dispose(self):
        HWArenaPhasesComponent.onPhaseChanged -= self._update
        super(HWPhaseIndicator, self)._dispose()

    def _update(self, arenaPhases):
        if arenaPhases:
            self.as_setDataS(arenaPhases.activePhase, arenaPhases.phasesCount)