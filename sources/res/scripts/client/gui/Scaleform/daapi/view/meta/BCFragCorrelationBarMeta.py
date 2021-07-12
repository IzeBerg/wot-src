from gui.Scaleform.daapi.view.battle.shared.frag_correlation_bar import FragCorrelationBar

class BCFragCorrelationBarMeta(FragCorrelationBar):

    def as_showHintS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showHint()