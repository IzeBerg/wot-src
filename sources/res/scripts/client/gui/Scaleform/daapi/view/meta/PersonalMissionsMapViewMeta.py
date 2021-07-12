from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PersonalMissionsMapViewMeta(BaseDAAPIComponent):

    def onRegionClick(self, id):
        self._printOverrideError('onRegionClick')

    def as_setPlanDataS(self, planData):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlanData(planData)

    def as_getPmTypeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getPmType()