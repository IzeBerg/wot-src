from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class ToolTipMgrMeta(BaseDAAPIComponent):

    def onCreateComplexTooltip(self, tooltipId, stateType):
        self._printOverrideError('onCreateComplexTooltip')

    def onCreateTypedTooltip(self, tooltipType, args, stateType):
        self._printOverrideError('onCreateTypedTooltip')

    def onHideTooltip(self, tooltipId):
        self._printOverrideError('onHideTooltip')

    def onCreateWulfTooltip(self, tooltipType, args, x, y):
        self._printOverrideError('onCreateWulfTooltip')

    def as_showS(self, tooltipData, linkage, redraw=False):
        if self._isDAAPIInited():
            return self.flashObject.as_show(tooltipData, linkage, redraw)

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()