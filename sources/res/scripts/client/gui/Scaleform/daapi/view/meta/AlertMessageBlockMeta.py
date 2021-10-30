from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class AlertMessageBlockMeta(BaseDAAPIComponent):

    def onButtonClick(self):
        self._printOverrideError('onButtonClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)