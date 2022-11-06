from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MiniClientComponentMeta(BaseDAAPIComponent):

    def onHyperlinkClick(self):
        self._printOverrideError('onHyperlinkClick')