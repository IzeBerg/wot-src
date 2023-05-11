from cosmic_event.gui.impl.lobby.banner_entry_point.cosmic_banner_entry_point import CosmicBannerEntryPointView
from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.CosmicBannerEntryPointMeta import CosmicBannerEntryPointMeta

class CosmicBannerEntryPoint(CosmicBannerEntryPointMeta):

    def _makeInjectView(self):
        return CosmicBannerEntryPointView(ViewFlags.COMPONENT)