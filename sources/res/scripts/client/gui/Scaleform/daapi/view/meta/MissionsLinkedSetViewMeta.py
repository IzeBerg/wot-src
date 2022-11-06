from gui.Scaleform.daapi.view.lobby.missions.regular.missions_page import LinkedSetMissionView

class MissionsLinkedSetViewMeta(LinkedSetMissionView):

    def useTokenClick(self, eventID):
        self._printOverrideError('useTokenClick')

    def expand(self, id, value):
        self._printOverrideError('expand')

    def as_setMaintenanceS(self, visible, message1, message2, buttonLabel):
        if self._isDAAPIInited():
            return self.flashObject.as_setMaintenance(visible, message1, message2, buttonLabel)

    def as_setPlayFadeInTweenEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayFadeInTweenEnabled(value)