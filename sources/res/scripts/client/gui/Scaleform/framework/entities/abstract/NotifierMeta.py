from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class NotifierMeta(BaseDAAPIComponent):

    def showDialog(self, kind, title, text, buttons, handlers):
        self._printOverrideError('showDialog')

    def showI18nDialog(self, kind, i18nKey, handlers):
        self._printOverrideError('showI18nDialog')