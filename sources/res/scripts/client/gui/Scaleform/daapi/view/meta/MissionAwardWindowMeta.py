from gui.Scaleform.daapi.view.lobby.award_window_base import AwardWindowBase

class MissionAwardWindowMeta(AwardWindowBase):

    def onCurrentQuestClick(self):
        self._printOverrideError('onCurrentQuestClick')

    def onNextQuestClick(self):
        self._printOverrideError('onNextQuestClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)