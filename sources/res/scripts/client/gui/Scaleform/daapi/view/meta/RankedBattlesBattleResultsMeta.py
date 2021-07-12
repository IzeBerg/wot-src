from gui.Scaleform.framework.entities.View import View

class RankedBattlesBattleResultsMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def onWidgetUpdate(self):
        self._printOverrideError('onWidgetUpdate')

    def animationCheckBoxSelected(self, value):
        self._printOverrideError('animationCheckBoxSelected')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)