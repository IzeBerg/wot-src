from gui.Scaleform.daapi.view.meta.EventBuffsPanelMeta import EventBuffsPanelMeta

class EventBuffsPanel(EventBuffsPanelMeta):

    def addBuffSlotS(self, idx, imageName, tooltipText):
        self.as_addBuffSlotS(idx, imageName, tooltipText)

    def removeBuffSlotS(self, idx):
        self.as_removeBuffSlotS(idx)