from gui.Scaleform.daapi.view.lobby.profile.ProfileSection import ProfileSection

class ProfileTechniqueMeta(ProfileSection):

    def setSelectedTableColumn(self, index, sortDirection):
        self._printOverrideError('setSelectedTableColumn')

    def setSeason(self, seasonId):
        self._printOverrideError('setSeason')

    def showVehiclesRating(self):
        self._printOverrideError('showVehiclesRating')

    def as_responseVehicleDossierS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_responseVehicleDossier(data)

    def as_setRatingButtonS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRatingButton(data)

    def as_setBtnCountersS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_setBtnCounters(counters)

    def as_setPrestigeVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPrestigeVisible(value)