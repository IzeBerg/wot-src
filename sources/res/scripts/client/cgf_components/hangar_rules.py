import CGF
from cgf_script.managers_registrator import registerManager, Rule, registerRule
from hover_component import HoverManager
from highlight_component import HighlightManager
from on_click_components import ClickManager
from hangar_camera_manager import HangarCameraManager, WTHangarManager

@registerRule
class SelectionRule(Rule):
    category = 'Hangar rules'
    domain = CGF.DomainOption.DomainClient

    @registerManager(HoverManager)
    def reg1(self):
        return

    @registerManager(HighlightManager)
    def reg2(self):
        return

    @registerManager(ClickManager)
    def reg3(self):
        return


@registerRule
class CameraRule(Rule):
    category = 'Hangar rules'
    domain = CGF.DomainOption.DomainClient

    @registerManager(HangarCameraManager)
    def reg1(self):
        return


@registerRule
class WTHangarRule(Rule):
    category = 'Hangar rules'
    domain = CGF.DomainOption.DomainClient

    @registerManager(WTHangarManager)
    def reg1(self):
        return