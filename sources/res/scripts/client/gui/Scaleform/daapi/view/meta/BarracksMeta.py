from gui.Scaleform.framework.entities.View import View

class BarracksMeta(View):

    def invalidateTanksList(self):
        self._printOverrideError('invalidateTanksList')

    def setFilter(self, nation, role, tankType, location, nationID):
        self._printOverrideError('setFilter')

    def onShowRecruitWindowClick(self, rendererData, menuEnabled):
        self._printOverrideError('onShowRecruitWindowClick')

    def actTankman(self, dataCompact):
        self._printOverrideError('actTankman')

    def buyBerths(self):
        self._printOverrideError('buyBerths')

    def closeBarracks(self):
        self._printOverrideError('closeBarracks')

    def setTankmenFilter(self):
        self._printOverrideError('setTankmenFilter')

    def openPersonalCase(self, value, tabNumber):
        self._printOverrideError('openPersonalCase')

    def onCountersVisited(self, visitedIds):
        self._printOverrideError('onCountersVisited')

    def as_setTankmenS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTankmen(data)

    def as_updateTanksListS(self, provider):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTanksList(provider)

    def as_setTankmenFilterS(self, nation, role, tankType, location, nationID):
        if self._isDAAPIInited():
            return self.flashObject.as_setTankmenFilter(nation, role, tankType, location, nationID)

    def as_switchFilterEnableS(self, nationEnable, roleEnable, typeEnable):
        if self._isDAAPIInited():
            return self.flashObject.as_switchFilterEnable(nationEnable, roleEnable, typeEnable)

    def as_setCountersDataS(self, countersData):
        if self._isDAAPIInited():
            return self.flashObject.as_setCountersData(countersData)

    def as_getDataProviderS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getDataProvider()