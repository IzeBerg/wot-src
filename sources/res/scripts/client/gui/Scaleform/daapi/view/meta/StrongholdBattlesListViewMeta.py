from gui.Scaleform.daapi.view.lobby.rally.BaseRallyListView import BaseRallyListView

class StrongholdBattlesListViewMeta(BaseRallyListView):

    def onFocusChange(self, hasFocus):
        self._printOverrideError('onFocusChange')

    def updateBrowser(self):
        self._printOverrideError('updateBrowser')