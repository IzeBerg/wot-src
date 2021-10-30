from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class CustomizationFiltersPopoverMeta(SmartPopOverView):

    def changeGroup(self, itemId):
        self._printOverrideError('changeGroup')

    def setDefaultFilter(self):
        self._printOverrideError('setDefaultFilter')

    def setShowOnlyHistoric(self, value):
        self._printOverrideError('setShowOnlyHistoric')

    def setShowOnlyAcquired(self, value):
        self._printOverrideError('setShowOnlyAcquired')

    def setHideOnAnotherVeh(self, value):
        self._printOverrideError('setHideOnAnotherVeh')

    def setShowOnlyProgressionDecals(self, value):
        self._printOverrideError('setShowOnlyProgressionDecals')

    def setShowOnlyEditableStyles(self, value):
        self._printOverrideError('setShowOnlyEditableStyles')

    def onFilterChange(self, index, value):
        self._printOverrideError('onFilterChange')

    def onFormChange(self, index, value):
        self._printOverrideError('onFormChange')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_enableDefBtnS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_enableDefBtn(value)