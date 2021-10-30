from gui.Scaleform.daapi.view.lobby.techtree.research_view import ResearchView

class TechTreeMeta(ResearchView):

    def requestNationTreeData(self):
        self._printOverrideError('requestNationTreeData')

    def getNationTreeData(self, nationName):
        self._printOverrideError('getNationTreeData')

    def getPremiumPanelLabels(self):
        self._printOverrideError('getPremiumPanelLabels')

    def request4Unlock(self, itemCD):
        self._printOverrideError('request4Unlock')

    def goToNextVehicle(self, vehCD):
        self._printOverrideError('goToNextVehicle')

    def onCloseTechTree(self):
        self._printOverrideError('onCloseTechTree')

    def request4VehCompare(self, vehCD):
        self._printOverrideError('request4VehCompare')

    def onBlueprintModeSwitch(self, enabled):
        self._printOverrideError('onBlueprintModeSwitch')

    def onGoToPremiumShop(self, nationName, level):
        self._printOverrideError('onGoToPremiumShop')

    def onPlayHintAnimation(self, isEnabled):
        self._printOverrideError('onPlayHintAnimation')

    def as_setAvailableNationsS(self, nations):
        if self._isDAAPIInited():
            return self.flashObject.as_setAvailableNations(nations)

    def as_setSelectedNationS(self, nationName):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedNation(nationName)

    def as_refreshNationTreeDataS(self, nationName):
        if self._isDAAPIInited():
            return self.flashObject.as_refreshNationTreeData(nationName)

    def as_setUnlockPropsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setUnlockProps(data)

    def as_hideNationsBarS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_hideNationsBar(value)

    def as_showMiniClientInfoS(self, description, hyperlink):
        if self._isDAAPIInited():
            return self.flashObject.as_showMiniClientInfo(description, hyperlink)

    def as_setBlueprintsSwitchButtonStateS(self, enabled, selected, tooltip, visible=True):
        if self._isDAAPIInited():
            return self.flashObject.as_setBlueprintsSwitchButtonState(enabled, selected, tooltip, visible)

    def as_setBlueprintModeS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setBlueprintMode(enabled)

    def as_setBlueprintBalanceS(self, balanceVO):
        if self._isDAAPIInited():
            return self.flashObject.as_setBlueprintBalance(balanceVO)

    def as_closePremiumPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_closePremiumPanel()

    def as_setVehicleCollectorStateS(self, enabled):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleCollectorState(enabled)