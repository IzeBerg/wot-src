from gui.Scaleform.daapi.view.battle.shared.base_stats import StatsBase

class EpicFullStatsMeta(StatsBase):

    def as_initializeTextS(self, myLaneText, allLanesText):
        if self._isDAAPIInited():
            return self.flashObject.as_initializeText(myLaneText, allLanesText)

    def as_setIsInteractiveS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsInteractive(value)