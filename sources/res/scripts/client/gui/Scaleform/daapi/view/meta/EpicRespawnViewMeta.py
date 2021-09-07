from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EpicRespawnViewMeta(BaseDAAPIComponent):

    def onLocationSelected(self, pointIdx):
        self._printOverrideError('onLocationSelected')

    def onRespawnBtnClick(self):
        self._printOverrideError('onRespawnBtnClick')

    def onDeploymentReady(self):
        self._printOverrideError('onDeploymentReady')

    def as_updateTimerS(self, timeIsOver, mainTimer):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTimer(timeIsOver, mainTimer)

    def as_updateAutoTimerS(self, timeIsOver, mainTimer):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAutoTimer(timeIsOver, mainTimer)

    def as_resetRespawnStateS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_resetRespawnState()

    def as_setSelectedLocationS(self, pointIdx):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedLocation(pointIdx)

    def as_setLaneStateS(self, laneId, value, blockReasonText):
        if self._isDAAPIInited():
            return self.flashObject.as_setLaneState(laneId, value, blockReasonText)

    def as_setMapDimensionsS(self, mapWidth, mapHeight):
        if self._isDAAPIInited():
            return self.flashObject.as_setMapDimensions(mapWidth, mapHeight)

    def as_setRespawnLocationsS(self, locations):
        if self._isDAAPIInited():
            return self.flashObject.as_setRespawnLocations(locations)

    def as_handleAsReplayS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_handleAsReplay()