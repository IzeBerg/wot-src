from fun_random.gui.feature.util.fun_mixins import FunSubModesWatcher
from fun_random.gui.feature.util.fun_wrappers import hasDesiredSubMode
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.platoon.members_window_model import PrebattleTypes
from gui.impl.lobby.platoon.view.platoon_members_view import SquadMembersView
from gui.impl.lobby.platoon.view.subview.platoon_chat_subview import ChatSubview

class FunRandomMembersView(SquadMembersView, FunSubModesWatcher):
    _prebattleType = PrebattleTypes.FUNRANDOM

    @hasDesiredSubMode(defReturn='')
    def _getTitle(self):
        subModeName = backport.text(self.getDesiredSubMode().getLocalsResRoot().userName())
        return backport.text(R.strings.fun_random.platoonView.title(), subModeName=subModeName)

    def _onFindPlayers(self):
        pass

    def _addSubviews(self):
        self._addSubviewToLayout(ChatSubview())

    def _addListeners(self):
        super(FunRandomMembersView, self)._addListeners()
        self.startSubSelectionListening(self.__onSubModeSelected)

    def _removeListeners(self):
        self.stopSubSelectionListening(self.__onSubModeSelected)
        super(FunRandomMembersView, self)._removeListeners()

    def _updateFindPlayersButton(self, *args):
        with self.viewModel.transaction() as (model):
            model.setShouldShowFindPlayersButton(value=False)

    def __onSubModeSelected(self, *_):
        self.viewModel.setRawTitle(self._getTitle())