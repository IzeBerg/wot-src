from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class InjectComponentMeta(BaseDAAPIComponent):

    def as_setPlaceIdS(self, placeId):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlaceId(placeId)