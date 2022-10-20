from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventBuffsPanelMeta(BaseDAAPIComponent):

    def as_addBuffSlotS(self, id, imageName, tooltipText):
        if self._isDAAPIInited():
            return self.flashObject.as_addBuffSlot(id, imageName, tooltipText)

    def as_removeBuffSlotS(self, id):
        if self._isDAAPIInited():
            return self.flashObject.as_removeBuffSlot(id)