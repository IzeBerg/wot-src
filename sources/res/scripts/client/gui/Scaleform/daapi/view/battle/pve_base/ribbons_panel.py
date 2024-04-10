from gui.Scaleform.daapi.view.battle.shared.ribbons_panel import BattleRibbonsPanel

class PveRibbonsPanel(BattleRibbonsPanel):

    def _populate(self):
        super(PveRibbonsPanel, self)._populate()
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched += self._onPostMortemSwitched
        return

    def _dispose(self):
        ctrl = self.sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onPostMortemSwitched -= self._onPostMortemSwitched
        super(PveRibbonsPanel, self)._dispose()
        return

    def _onPostMortemSwitched(self, *_):
        if not self.sessionProvider.getCtx().isPlayerObserver():
            self.as_resetS()