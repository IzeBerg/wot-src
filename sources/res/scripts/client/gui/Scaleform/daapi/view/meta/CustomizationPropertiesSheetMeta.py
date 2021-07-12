from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CustomizationPropertiesSheetMeta(BaseDAAPIComponent):

    def onActionBtnClick(self, actionType, actionData):
        self._printOverrideError('onActionBtnClick')

    def elementControlsHide(self):
        self._printOverrideError('elementControlsHide')

    def onClose(self):
        self._printOverrideError('onClose')

    def registerInscriptionController(self, inscriptionController, inputLines):
        self._printOverrideError('registerInscriptionController')

    def as_setDataAndShowS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setDataAndShow(data)

    def as_setArrowsStatesS(self, left, right):
        if self._isDAAPIInited():
            return self.flashObject.as_setArrowsStates(left, right)

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()