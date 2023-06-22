from fun_random.gui.impl.lobby.feature.fun_random_strengths_weaknesses_panel import FunRandomStrengthsWeaknessesPanel
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class StrengthsWeaknessesPanelInject(InjectComponentAdaptor):
    __slots__ = ()

    def _makeInjectView(self, *args):
        return FunRandomStrengthsWeaknessesPanel()