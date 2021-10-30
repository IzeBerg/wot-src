from gui.Scaleform.daapi.view.dialogs.SimpleDialog import SimpleDialog

class CrewSkinsCompensationDialogMeta(SimpleDialog):

    def as_setListS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setList(data)

    def as_setMessagePriceS(self, dialogData):
        if self._isDAAPIInited():
            return self.flashObject.as_setMessagePrice(dialogData)

    def as_setPriceLabelS(self, label):
        if self._isDAAPIInited():
            return self.flashObject.as_setPriceLabel(label)

    def as_setOperationAllowedS(self, isAllowed):
        if self._isDAAPIInited():
            return self.flashObject.as_setOperationAllowed(isAllowed)