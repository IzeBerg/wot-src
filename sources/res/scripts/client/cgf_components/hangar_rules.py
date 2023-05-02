import CGF
from cgf_script.managers_registrator import registerManager, Rule
from hover_component import HoverManager
from highlight_component import HighlightManager
from on_click_components import ClickManager

class SelectionRule(Rule):
    category = 'Hangar rules'
    domain = CGF.DomainOption.DomainClient | CGF.DomainOption.DomainEditor

    @registerManager(HoverManager)
    def reg1(self):
        return

    @registerManager(HighlightManager)
    def reg2(self):
        return

    @registerManager(ClickManager)
    def reg3(self):
        return