from gui.Scaleform.daapi.view.dialogs.SimpleDialog import SimpleDialog

class EventAFKDialogMeta(SimpleDialog):

    def as_setDataS(self, imagePath):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(imagePath)