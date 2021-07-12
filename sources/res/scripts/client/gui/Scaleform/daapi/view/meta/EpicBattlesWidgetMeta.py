from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EpicBattlesWidgetMeta(BaseDAAPIComponent):

    def onWidgetClick(self):
        self._printOverrideError('onWidgetClick')

    def onAnimationFinished(self):
        self._printOverrideError('onAnimationFinished')

    def onSoundTrigger(self, trigerName):
        self._printOverrideError('onSoundTrigger')

    def onChangeServerClick(self):
        self._printOverrideError('onChangeServerClick')

    def onQuestBtnClick(self, questType, questID):
        self._printOverrideError('onQuestBtnClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)