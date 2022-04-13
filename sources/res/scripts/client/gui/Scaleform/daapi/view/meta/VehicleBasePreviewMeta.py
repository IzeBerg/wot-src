from gui.Scaleform.framework.entities.View import View

class VehicleBasePreviewMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def onBackClick(self):
        self._printOverrideError('onBackClick')

    def onOpenInfoTab(self, index):
        self._printOverrideError('onOpenInfoTab')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setAdditionalInfoS(self, info):
        if self._isDAAPIInited():
            return self.flashObject.as_setAdditionalInfo(info)

    def as_show3DSceneTooltipS(self, id, args):
        if self._isDAAPIInited():
            return self.flashObject.as_show3DSceneTooltip(id, args)

    def as_hide3DSceneTooltipS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide3DSceneTooltip()

    def as_setTopPanelS(self, linkage):
        if self._isDAAPIInited():
            return self.flashObject.as_setTopPanel(linkage)

    def as_setBottomPanelS(self, linkage):
        if self._isDAAPIInited():
            return self.flashObject.as_setBottomPanel(linkage)