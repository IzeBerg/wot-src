from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CrewMeta(BaseDAAPIComponent):

    def onShowRecruitWindowClick(self, rendererData, menuEnabled):
        self._printOverrideError('onShowRecruitWindowClick')

    def unloadAllTankman(self):
        self._printOverrideError('unloadAllTankman')

    def equipTankman(self, tankmanID, slot):
        self._printOverrideError('equipTankman')

    def updateTankmen(self):
        self._printOverrideError('updateTankmen')

    def openPersonalCase(self, value, tabID):
        self._printOverrideError('openPersonalCase')

    def onCrewDogMoreInfoClick(self):
        self._printOverrideError('onCrewDogMoreInfoClick')

    def onCrewDogItemClick(self):
        self._printOverrideError('onCrewDogItemClick')

    def as_tankmenResponseS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_tankmenResponse(data)

    def as_dogResponseS(self, dogName):
        if self._isDAAPIInited():
            return self.flashObject.as_dogResponse(dogName)

    def as_setDogTooltipS(self, tooltipId):
        if self._isDAAPIInited():
            return self.flashObject.as_setDogTooltip(tooltipId)