from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.MapBoxEntryPointMeta import MapBoxEntryPointMeta
from gui.impl.lobby.mapbox.mapbox_entry_point_view import MapBoxEntryPointView

class MapBoxEntryPoint(MapBoxEntryPointMeta):

    def _makeInjectView(self):
        self.__view = MapBoxEntryPointView(ViewFlags.VIEW)
        return self.__view