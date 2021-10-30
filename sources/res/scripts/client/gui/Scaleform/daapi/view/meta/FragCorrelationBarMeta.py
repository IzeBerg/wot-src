from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class FragCorrelationBarMeta(BaseDAAPIComponent):

    def as_updateTeamHealthValuesS(self, allyTeamHealth, diffValue, allyTeamHealthPercentage, enemyTeamHealth, enemyTeamHealthPercentage):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTeamHealthValues(allyTeamHealth, diffValue, allyTeamHealthPercentage, enemyTeamHealth, enemyTeamHealthPercentage)

    def as_updateViewSettingS(self, setting):
        if self._isDAAPIInited():
            return self.flashObject.as_updateViewSetting(setting)