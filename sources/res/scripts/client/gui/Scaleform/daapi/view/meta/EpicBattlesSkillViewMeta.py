from gui.Scaleform.daapi.view.meta.WrapperViewMeta import WrapperViewMeta

class EpicBattlesSkillViewMeta(WrapperViewMeta):

    def onEscapePress(self):
        self._printOverrideError('onEscapePress')

    def onBackBtnClick(self):
        self._printOverrideError('onBackBtnClick')

    def onCloseBtnClick(self):
        self._printOverrideError('onCloseBtnClick')

    def onSelectSkillBtnClick(self, skillID):
        self._printOverrideError('onSelectSkillBtnClick')

    def onSkillUpgrade(self, skillID):
        self._printOverrideError('onSkillUpgrade')

    def onSkillOverLevel(self, skillID, level):
        self._printOverrideError('onSkillOverLevel')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_updateDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateData(data)

    def as_setSelectedSkillS(self, skillID):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedSkill(skillID)

    def as_setSkillDataBlockS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setSkillDataBlock(data)