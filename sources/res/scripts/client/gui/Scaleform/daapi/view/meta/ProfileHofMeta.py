from gui.Scaleform.daapi.view.lobby.profile.ProfileSection import ProfileSection

class ProfileHofMeta(ProfileSection):

    def showVehiclesRating(self):
        self._printOverrideError('showVehiclesRating')

    def showAchievementsRating(self):
        self._printOverrideError('showAchievementsRating')

    def changeStatus(self):
        self._printOverrideError('changeStatus')

    def as_setStatusS(self, state):
        if self._isDAAPIInited():
            return self.flashObject.as_setStatus(state)

    def as_setBackgroundS(self, source):
        if self._isDAAPIInited():
            return self.flashObject.as_setBackground(source)

    def as_setBtnCountersS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_setBtnCounters(counters)

    def as_showServiceViewS(self, header, description):
        if self._isDAAPIInited():
            return self.flashObject.as_showServiceView(header, description)

    def as_hideServiceViewS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideServiceView()

    def as_showWaitingS(self, description):
        if self._isDAAPIInited():
            return self.flashObject.as_showWaiting(description)

    def as_hideWaitingS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideWaiting()