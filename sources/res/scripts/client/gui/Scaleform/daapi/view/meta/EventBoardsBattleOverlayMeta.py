from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventBoardsBattleOverlayMeta(BaseDAAPIComponent):

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setExperienceDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setExperienceData(data)

    def as_setStatisticsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setStatisticsData(data)

    def as_setTableHeaderDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTableHeaderData(data)

    def as_setTableDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTableData(data)