from gui.Scaleform.daapi.view.battle.classic.stats_exchange import ClassicStatisticsDataController

class Comp7BattleStatisticDataControllerMeta(ClassicStatisticsDataController):

    def as_removePointOfInterestS(self, vehicleID, type):
        if self._isDAAPIInited():
            return self.flashObject.as_removePointOfInterest(vehicleID, type)

    def as_updatePointOfInterestS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePointOfInterest(data)