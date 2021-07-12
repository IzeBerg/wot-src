from gui.Scaleform.daapi.view.lobby.techtree.research_view import ResearchView

class ResearchMeta(ResearchView):

    def requestResearchData(self):
        self._printOverrideError('requestResearchData')

    def request4Unlock(self, itemCD, topLevel):
        self._printOverrideError('request4Unlock')

    def request4Rent(self, itemCD):
        self._printOverrideError('request4Rent')

    def goToNextVehicle(self, vehCD):
        self._printOverrideError('goToNextVehicle')

    def exitFromResearch(self):
        self._printOverrideError('exitFromResearch')

    def goToVehicleView(self, itemCD):
        self._printOverrideError('goToVehicleView')

    def compareVehicle(self, itemCD):
        self._printOverrideError('compareVehicle')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_setRootDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRootData(data)

    def as_setResearchItemsS(self, nation, raw):
        if self._isDAAPIInited():
            return self.flashObject.as_setResearchItems(nation, raw)

    def as_setFreeXPS(self, freeXP):
        if self._isDAAPIInited():
            return self.flashObject.as_setFreeXP(freeXP)

    def as_setInstalledItemsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInstalledItems(data)

    def as_setWalletStatusS(self, walletStatus):
        if self._isDAAPIInited():
            return self.flashObject.as_setWalletStatus(walletStatus)

    def as_setXpInfoLinkageS(self, linkage):
        if self._isDAAPIInited():
            return self.flashObject.as_setXpInfoLinkage(linkage)