from gui.Scaleform.daapi.view.lobby.missions.regular.missions_page import MissionView

class MissionsGroupedViewMeta(MissionView):

    def expand(self, id, value):
        self._printOverrideError('expand')

    def clickActionBtn(self, actionID):
        self._printOverrideError('clickActionBtn')

    def openTokenPopover(self, id):
        self._printOverrideError('openTokenPopover')

    def useTokenClick(self, eventID):
        self._printOverrideError('useTokenClick')

    def onClickButtonDetails(self):
        self._printOverrideError('onClickButtonDetails')

    def onGotoRtsQuestsClick(self):
        self._printOverrideError('onGotoRtsQuestsClick')