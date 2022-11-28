from cgf_script.managers_registrator import registerManager, Rule
from hover_component import HoverManager
from highlight_component import HighlightManager
from on_click_components import ClickManager
from hangar_camera_manager import HangarCameraManager

class SelectionRule(Rule):
    category = 'Hangar rules'

    @registerManager(HoverManager)
    def reg1(self):
        return

    @registerManager(HighlightManager)
    def reg2(self):
        return

    @registerManager(ClickManager)
    def reg3(self):
        return


class CameraRule(Rule):
    category = 'Hangar rules'

    @registerManager(HangarCameraManager)
    def reg1(self):
        return