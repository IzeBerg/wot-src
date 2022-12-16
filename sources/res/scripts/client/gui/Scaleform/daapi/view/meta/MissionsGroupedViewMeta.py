from gui.Scaleform.daapi.view.lobby.missions.regular.missions_page import MissionView

class MissionsGroupedViewMeta(MissionView):

    def expand(self, id, value):
        self._printOverrideError('expand')

    def clickActionBtn(self, actionID):
        self._printOverrideError('clickActionBtn')

    def onClickButtonDetails(self):
        self._printOverrideError('onClickButtonDetails')