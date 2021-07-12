from gui.Scaleform.daapi.view.meta.VehicleCompareCommonViewMeta import VehicleCompareCommonViewMeta

class VehicleCompareConfiguratorMainMeta(VehicleCompareCommonViewMeta):

    def as_showViewS(self, alias):
        if self._isDAAPIInited():
            return self.flashObject.as_showView(alias)