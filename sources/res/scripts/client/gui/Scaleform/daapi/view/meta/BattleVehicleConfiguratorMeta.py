from gui.Scaleform.framework.entities.View import View

class BattleVehicleConfiguratorMeta(View):

    def onModuleMouseOver(self, intCD):
        self._printOverrideError('onModuleMouseOver')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setVisibleS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(isVisible)

    def as_updateModuleInfoPanelS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateModuleInfoPanel(data)

    def as_updateChoiceInfoPanelS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateChoiceInfoPanel(data)