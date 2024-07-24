from races.gui.impl.lobby.races_banner.races_banner_view import RacesBannerView
from frameworks.wulf import ViewFlags
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor

class RacesBannerEntryPoint(InjectComponentAdaptor):

    def _makeInjectView(self):
        return RacesBannerView(ViewFlags.VIEW)