from gui.Scaleform.daapi.view.lobby.prb_windows.squad_view import SquadView

class EventSquadViewMeta(SquadView):

    def selectDifficulty(self, value):
        self._printOverrideError('selectDifficulty')

    def as_updateDifficultyS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateDifficulty(data)

    def as_enableDifficultyDropdownS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_enableDifficultyDropdown(value)