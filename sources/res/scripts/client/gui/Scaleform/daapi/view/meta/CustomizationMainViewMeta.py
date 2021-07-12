from gui.Scaleform.framework.entities.View import View

class CustomizationMainViewMeta(View):

    def showBuyWindow(self):
        self._printOverrideError('showBuyWindow')

    def onCloseWindow(self):
        self._printOverrideError('onCloseWindow')

    def fadeOutAnchors(self, value):
        self._printOverrideError('fadeOutAnchors')

    def changeSeason(self, season, keepSelect):
        self._printOverrideError('changeSeason')

    def onLobbyClick(self):
        self._printOverrideError('onLobbyClick')

    def onSelectAnchor(self, areaID, slotID, regionID):
        self._printOverrideError('onSelectAnchor')

    def onHoverAnchor(self, areaID, slotID, regionID, hover):
        self._printOverrideError('onHoverAnchor')

    def onDragAnchor(self, areaID, slotID, regionID):
        self._printOverrideError('onDragAnchor')

    def onReleaseItem(self):
        self._printOverrideError('onReleaseItem')

    def onAnchorsShown(self, anchors):
        self._printOverrideError('onAnchorsShown')

    def propertiesSheetSet(self, sheet, width, height, crnterX, centerY):
        self._printOverrideError('propertiesSheetSet')

    def onPressClearBtn(self):
        self._printOverrideError('onPressClearBtn')

    def onPressEscBtn(self):
        self._printOverrideError('onPressEscBtn')

    def onPressSelectNextItem(self, reverse):
        self._printOverrideError('onPressSelectNextItem')

    def playCustomSound(self, sound):
        self._printOverrideError('playCustomSound')

    def onRemoveSelectedItem(self):
        self._printOverrideError('onRemoveSelectedItem')

    def resetC11nItemsNovelty(self, itemsList):
        self._printOverrideError('resetC11nItemsNovelty')

    def onProgressionEntryPointClick(self):
        self._printOverrideError('onProgressionEntryPointClick')

    def as_hideS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_hide(value)

    def as_setHeaderDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeaderData(data)

    def as_setAnchorInitS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setAnchorInit(data)

    def as_updateAnchorDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAnchorData(data)

    def as_onRegionHighlightedS(self, slotId, highlightingType, highlightingResult, areaMouseBehavior):
        if self._isDAAPIInited():
            return self.flashObject.as_onRegionHighlighted(slotId, highlightingType, highlightingResult, areaMouseBehavior)

    def as_updateSelectedRegionsS(self, slotId):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSelectedRegions(slotId)

    def as_setAnchorsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setAnchorsData(data)

    def as_setSeasonsBarDataS(self, dataProvider):
        if self._isDAAPIInited():
            return self.flashObject.as_setSeasonsBarData(dataProvider)

    def as_enableDNDS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_enableDND(value)

    def as_selectSeasonS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_selectSeason(value)

    def as_releaseItemS(self, deselectAnchor=True):
        if self._isDAAPIInited():
            return self.flashObject.as_releaseItem(deselectAnchor)

    def as_showCarouselsArrowsNotificationS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_showCarouselsArrowsNotification(text)

    def as_reselectS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_reselect(data)

    def as_setNotificationCountersS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_setNotificationCounters(counters)

    def as_setAnchorsStateS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setAnchorsState(data)

    def as_attachToCursorS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_attachToCursor(data)

    def as_progressionEntryPointVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_progressionEntryPointVisible(value)