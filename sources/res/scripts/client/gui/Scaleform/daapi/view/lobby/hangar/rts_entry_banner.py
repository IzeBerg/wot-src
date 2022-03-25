from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.RTSEntryBannerMeta import RTSEntryBannerMeta
from gui.impl.lobby.rts.entry_banner_view import EntryBannerView

class RTSEntryBanner(RTSEntryBannerMeta):

    def _makeInjectView(self):
        self.__view = EntryBannerView(ViewFlags.COMPONENT)
        return self.__view