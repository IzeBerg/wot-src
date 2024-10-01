from gui.Scaleform.daapi.view.meta.MissionsViewBaseMeta import MissionsViewBaseMeta

class MissionsMarathonViewMeta(MissionsViewBaseMeta):

    def as_showViewS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showView()

    def as_setPlaceIdS(self, placeId):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlaceId(placeId)