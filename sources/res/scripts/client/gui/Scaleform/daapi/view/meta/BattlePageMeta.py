from gui.Scaleform.framework.entities.View import View

class BattlePageMeta(View):

    def as_checkDAAPIS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_checkDAAPI()

    def as_onPostmortemActiveS(self, isPostMortem):
        if self._isDAAPIInited():
            return self.flashObject.as_onPostmortemActive(isPostMortem)

    def as_setComponentsVisibilityS(self, visible, hidden):
        if self._isDAAPIInited():
            return self.flashObject.as_setComponentsVisibility(visible, hidden)

    def as_setComponentsVisibilityWithFadeS(self, visible, hidden):
        if self._isDAAPIInited():
            return self.flashObject.as_setComponentsVisibilityWithFade(visible, hidden)

    def as_isComponentVisibleS(self, componentKey):
        if self._isDAAPIInited():
            return self.flashObject.as_isComponentVisible(componentKey)

    def as_getComponentsVisibilityS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getComponentsVisibility()

    def as_toggleCtrlPressFlagS(self, isCtrlPressed):
        if self._isDAAPIInited():
            return self.flashObject.as_toggleCtrlPressFlag(isCtrlPressed)

    def as_createRoleDescriptionS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_createRoleDescription()

    def as_setArtyShotIndicatorFlagS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setArtyShotIndicatorFlag(isVisible)

    def as_togglePiercingPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_togglePiercingPanel()