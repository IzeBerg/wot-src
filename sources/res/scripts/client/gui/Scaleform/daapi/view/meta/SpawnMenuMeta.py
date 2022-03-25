from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SpawnMenuMeta(BaseDAAPIComponent):

    def onBGClick(self):
        self._printOverrideError('onBGClick')

    def onAutoSetBtnClick(self):
        self._printOverrideError('onAutoSetBtnClick')

    def onResetBtnClick(self):
        self._printOverrideError('onResetBtnClick')

    def onBattleBtnClick(self):
        self._printOverrideError('onBattleBtnClick')

    def onSupplySelect(self, classTag):
        self._printOverrideError('onSupplySelect')

    def onVehicleSelect(self, vehicleID):
        self._printOverrideError('onVehicleSelect')

    def onPointClick(self, pointID):
        self._printOverrideError('onPointClick')

    def as_setDataS(self, data, mapData):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data, mapData)

    def as_setItemsDataS(self, alliesData, suppliesData):
        if self._isDAAPIInited():
            return self.flashObject.as_setItemsData(alliesData, suppliesData)

    def as_updateEntriesDataS(self, placePointsData, suppliesData, vehiclesData):
        if self._isDAAPIInited():
            return self.flashObject.as_updateEntriesData(placePointsData, suppliesData, vehiclesData)

    def as_setIsWaitingPlayersS(self, isWaitingPlayers):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsWaitingPlayers(isWaitingPlayers)

    def as_setIsAutoSetBtnEnabledS(self, isAutoSetBtnEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsAutoSetBtnEnabled(isAutoSetBtnEnabled)

    def as_setIsResetBtnEnabledS(self, isResetBtnEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsResetBtnEnabled(isResetBtnEnabled)

    def as_setIsBattleBtnEnabledS(self, isBattleBtnEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsBattleBtnEnabled(isBattleBtnEnabled)

    def as_setIsBootcampS(self, isBootcamp):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsBootcamp(isBootcamp)

    def as_showMapHintS(self, isVisible, colorState, textValue):
        if self._isDAAPIInited():
            return self.flashObject.as_showMapHint(isVisible, colorState, textValue)