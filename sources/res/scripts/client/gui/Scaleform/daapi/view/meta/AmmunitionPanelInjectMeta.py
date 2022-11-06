from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class AmmunitionPanelInjectMeta(InjectComponentAdaptor):

    def onHangarSwitchAnimComplete(self, isComplete):
        self._printOverrideError('onHangarSwitchAnimComplete')

    def as_setPanelSizeS(self, panelWidth, panelHeight, offsetY):
        if self._isDAAPIInited():
            return self.flashObject.as_setPanelSize(panelWidth, panelHeight, offsetY)

    def as_setHelpLayoutS(self, helpLayoutData):
        if self._isDAAPIInited():
            return self.flashObject.as_setHelpLayout(helpLayoutData)

    def as_clearHelpLayoutS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_clearHelpLayout()