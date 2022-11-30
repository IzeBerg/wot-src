from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventBuffsPanelMeta(BaseDAAPIComponent):

    def as_addBuffSlotS(self, idx, imageName, tooltipText):
        if self._isDAAPIInited():
            return self.flashObject.as_addBuffSlot(idx, imageName, tooltipText)

    def as_removeBuffSlotS(self, idx):
        if self._isDAAPIInited():
            return self.flashObject.as_removeBuffSlot(idx)