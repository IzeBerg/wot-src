from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EpicOverviewMapScreenMeta(BaseDAAPIComponent):

    def as_setKeyBindingsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setKeyBindings(data)

    def as_updateLaneButtonNamesS(self, west, center, east):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLaneButtonNames(west, center, east)