from gui.Scaleform.framework.entities.View import View

class BaseMissionDetailsContainerViewMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def requestMissionData(self, index):
        self._printOverrideError('requestMissionData')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_setMissionDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setMissionData(data)