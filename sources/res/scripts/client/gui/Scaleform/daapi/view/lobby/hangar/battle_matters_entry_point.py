from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.battle_matters.battle_matters_entry_point_view import BattleMattersEntryPointView
from shared_utils import nextTick

class BattleMattersEntryPoint(InjectComponentAdaptor):

    @nextTick
    def _createInjectView(self, *args):
        super(BattleMattersEntryPoint, self)._createInjectView(*args)

    def _makeInjectView(self):
        return BattleMattersEntryPointView()