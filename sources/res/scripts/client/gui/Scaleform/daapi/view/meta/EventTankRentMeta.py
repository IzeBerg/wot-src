from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventTankRentMeta(BaseDAAPIComponent):

    def onEventRentClick(self):
        self._printOverrideError('onEventRentClick')

    def onToQuestsClick(self):
        self._printOverrideError('onToQuestsClick')

    def as_setRentDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRentData(data)

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)