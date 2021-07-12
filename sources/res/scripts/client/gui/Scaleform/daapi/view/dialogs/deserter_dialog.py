from gui.Scaleform.daapi.view.meta.DeserterDialogMeta import DeserterDialogMeta

class IngameDeserterDialog(DeserterDialogMeta):

    def __init__(self, meta, handler):
        super(IngameDeserterDialog, self).__init__(meta.getMessage(), meta.getTitle(), meta.getButtonLabels(), meta.getCallbackWrapper(handler))
        self.__imagePath = meta.getImagePath()
        self.__offsetY = meta.getOffsetY()

    def _populate(self):
        super(IngameDeserterDialog, self)._populate()
        self.as_setDataS(self.__imagePath, self.__offsetY)