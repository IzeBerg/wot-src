from cosmic_event.gui.impl.lobby.banner_entry_point.cosmic_banner_entry_point import CosmicBannerEntryPointView
from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.CosmicBannerEntryPointMeta import CosmicBannerEntryPointMeta

class CosmicBannerEntryPoint(CosmicBannerEntryPointMeta):

    def isSingle(self, value):
        if self.__view:
            self.__view.setIsSingle(value)

    def _makeInjectView(self):
        self.__view = CosmicBannerEntryPointView(ViewFlags.VIEW)
        return self.__view