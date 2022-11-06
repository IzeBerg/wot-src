from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CalloutPanelMeta(BaseDAAPIComponent):

    def onHideCompleted(self):
        self._printOverrideError('onHideCompleted')

    def onHideStart(self):
        self._printOverrideError('onHideStart')

    def as_setDataS(self, action, vehicleType, vehicleName, leftText, rightText, keyText):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(action, vehicleType, vehicleName, leftText, rightText, keyText)

    def as_setHideDataS(self, wasAnswered, answeredAction):
        if self._isDAAPIInited():
            return self.flashObject.as_setHideData(wasAnswered, answeredAction)