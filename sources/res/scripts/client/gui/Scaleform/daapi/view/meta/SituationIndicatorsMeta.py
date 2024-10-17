from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SituationIndicatorsMeta(BaseDAAPIComponent):

    def as_setPerksS(self, items):
        if self._isDAAPIInited():
            return self.flashObject.as_setPerks(items)

    def as_updatePerkS(self, perkName, state, duration, lifeTime):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePerk(perkName, state, duration, lifeTime)

    def as_setWeatherS(self, items):
        if self._isDAAPIInited():
            return self.flashObject.as_setWeather(items)

    def as_updateWeatherS(self, weatherName, state, toolTip):
        if self._isDAAPIInited():
            return self.flashObject.as_updateWeather(weatherName, state, toolTip)

    def as_clearPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_clearPanel()

    def as_replayPauseS(self, isPaused):
        if self._isDAAPIInited():
            return self.flashObject.as_replayPause(isPaused)