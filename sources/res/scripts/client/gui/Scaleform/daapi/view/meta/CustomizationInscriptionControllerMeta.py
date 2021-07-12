from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CustomizationInscriptionControllerMeta(BaseDAAPIComponent):

    def sendChar(self, char):
        self._printOverrideError('sendChar')

    def finish(self):
        self._printOverrideError('finish')

    def removeChar(self):
        self._printOverrideError('removeChar')

    def deleteAll(self):
        self._printOverrideError('deleteAll')

    def as_showS(self, inscriptionLength):
        if self._isDAAPIInited():
            return self.flashObject.as_show(inscriptionLength)

    def as_hideS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hide()

    def as_invalidInscriptionS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_invalidInscription(data)

    def as_showHintS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_showHint(data)