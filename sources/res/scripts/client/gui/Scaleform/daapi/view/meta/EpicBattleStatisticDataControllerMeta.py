from gui.Scaleform.daapi.view.battle.shared.stats_exchange.stats_ctrl import BattleStatisticsDataController

class EpicBattleStatisticDataControllerMeta(BattleStatisticsDataController):

    def as_updateEpicPlayerStatsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateEpicPlayerStats(data)

    def as_setEpicVehiclesStatsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setEpicVehiclesStats(data)

    def as_updateEpicVehiclesStatsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateEpicVehiclesStats(data)