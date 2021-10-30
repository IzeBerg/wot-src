from gui.Scaleform.framework.entities.View import View

class VehicleCompareCommonViewMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')