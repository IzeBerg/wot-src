from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.rts.tutorial.rts_tutorial_banner_view import RTSTutorialBannerView

class RTSBannerWidget(InjectComponentAdaptor):

    def _makeInjectView(self):
        return RTSTutorialBannerView()