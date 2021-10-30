from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class DialogsManagerMeta(BaseDAAPIComponent):

    def showSimpleI18nDialog(self, i18nKey, handlers):
        self._printOverrideError('showSimpleI18nDialog')