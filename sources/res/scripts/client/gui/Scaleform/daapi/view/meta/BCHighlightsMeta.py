from gui.Scaleform.framework.entities.View import View

class BCHighlightsMeta(View):

    def onComponentTriggered(self, highlightId):
        self._printOverrideError('onComponentTriggered')

    def onHighlightAnimationComplete(self, highlightId):
        self._printOverrideError('onHighlightAnimationComplete')

    def as_setDescriptorsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDescriptors(data)

    def as_addHighlightS(self, highlightId):
        if self._isDAAPIInited():
            return self.flashObject.as_addHighlight(highlightId)

    def as_removeHighlightS(self, highlightId):
        if self._isDAAPIInited():
            return self.flashObject.as_removeHighlight(highlightId)