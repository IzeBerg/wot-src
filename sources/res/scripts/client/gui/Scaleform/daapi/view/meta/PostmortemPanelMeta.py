from gui.Scaleform.daapi.view.meta.BasePostmortemPanelMeta import BasePostmortemPanelMeta

class PostmortemPanelMeta(BasePostmortemPanelMeta):

    def onDogTagKillerInPlaySound(self):
        self._printOverrideError('onDogTagKillerInPlaySound')

    def onDogTagKillerOutPlaySound(self):
        self._printOverrideError('onDogTagKillerOutPlaySound')

    def onVictimDogTagInPlaySound(self):
        self._printOverrideError('onVictimDogTagInPlaySound')

    def as_setPlayerInfoS(self, playerInfo):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerInfo(playerInfo)

    def as_showKillerDogTagS(self, data, fadeOut):
        if self._isDAAPIInited():
            return self.flashObject.as_showKillerDogTag(data, fadeOut)

    def as_showVictimDogTagS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showVictimDogTag(data)

    def as_preloadComponentsS(self, components):
        if self._isDAAPIInited():
            return self.flashObject.as_preloadComponents(components)

    def as_hideComponentsS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideComponents()

    def as_handleAsReplayS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_handleAsReplay()

    def as_togglePostmortemInfoPanelS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_togglePostmortemInfoPanel(isVisible)

    def as_movePostmortemPanelUpS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_movePostmortemPanelUp()

    def as_resetPostmortemPositionS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resetPostmortemPosition()

    def as_fadePostmortemPanelOutS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_fadePostmortemPanelOut()

    def as_setInDeathCamS(self, isInDeathCam):
        if self._isDAAPIInited():
            return self.flashObject.as_setInDeathCam(isInDeathCam)