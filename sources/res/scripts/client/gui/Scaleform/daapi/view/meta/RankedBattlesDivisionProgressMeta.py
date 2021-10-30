from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RankedBattlesDivisionProgressMeta(BaseDAAPIComponent):

    def as_setStatsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setStatsData(data)

    def as_setBonusBattlesLabelS(self, label):
        if self._isDAAPIInited():
            return self.flashObject.as_setBonusBattlesLabel(label)

    def as_setRankedDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRankedData(data)

    def as_setDivisionStatusS(self, title, description):
        if self._isDAAPIInited():
            return self.flashObject.as_setDivisionStatus(title, description)