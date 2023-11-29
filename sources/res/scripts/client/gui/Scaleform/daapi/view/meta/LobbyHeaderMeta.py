from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class LobbyHeaderMeta(BaseDAAPIComponent):

    def menuItemClick(self, alias):
        self._printOverrideError('menuItemClick')

    def showLobbyMenu(self):
        self._printOverrideError('showLobbyMenu')

    def showDashboard(self):
        self._printOverrideError('showDashboard')

    def showExchangeWindow(self):
        self._printOverrideError('showExchangeWindow')

    def showExchangeXPWindow(self):
        self._printOverrideError('showExchangeXPWindow')

    def showWotPlusView(self):
        self._printOverrideError('showWotPlusView')

    def showPremiumView(self):
        self._printOverrideError('showPremiumView')

    def onPremShopClick(self):
        self._printOverrideError('onPremShopClick')

    def onReservesClick(self):
        self._printOverrideError('onReservesClick')

    def onCrystalClick(self):
        self._printOverrideError('onCrystalClick')

    def onPayment(self):
        self._printOverrideError('onPayment')

    def movePlatoonPopover(self, popoverCenterX):
        self._printOverrideError('movePlatoonPopover')

    def showSquad(self, popoverCenterX):
        self._printOverrideError('showSquad')

    def openFullscreenBattleSelector(self):
        self._printOverrideError('openFullscreenBattleSelector')

    def closeFullscreenBattleSelector(self):
        self._printOverrideError('closeFullscreenBattleSelector')

    def fightClick(self, mapID, actionName):
        self._printOverrideError('fightClick')

    def as_setScreenS(self, alias):
        if self._isDAAPIInited():
            return self.flashObject.as_setScreen(alias)

    def as_updateWalletBtnS(self, btnID, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateWalletBtn(btnID, data)

    def as_doDisableNavigationS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_doDisableNavigation()

    def as_doDisableHeaderButtonS(self, btnId, isEnabled):
        if self._isDAAPIInited():
            return self.flashObject.as_doDisableHeaderButton(btnId, isEnabled)

    def as_doSoftDisableHeaderButtonS(self, btnId, isSoftDisable):
        if self._isDAAPIInited():
            return self.flashObject.as_doSoftDisableHeaderButton(btnId, isSoftDisable)

    def as_doDeselectHeaderButtonS(self, alias):
        if self._isDAAPIInited():
            return self.flashObject.as_doDeselectHeaderButton(alias)

    def as_setGoldFishEnabledS(self, isEnabled, playAnimation, tooltip, tooltipType):
        if self._isDAAPIInited():
            return self.flashObject.as_setGoldFishEnabled(isEnabled, playAnimation, tooltip, tooltipType)

    def as_updateSquadS(self, isInSquad, tooltip, tooltipType, isEvent, icon, hasPopover, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSquad(isInSquad, tooltip, tooltipType, isEvent, icon, hasPopover, data)

    def as_nameResponseS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_nameResponse(data)

    def as_setBadgeS(self, data, selected):
        if self._isDAAPIInited():
            return self.flashObject.as_setBadge(data, selected)

    def as_setWotPlusDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setWotPlusData(data)

    def as_setPremiumParamsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setPremiumParams(data)

    def as_setPremShopDataS(self, iconSrc, premShopText, tooltip, tooltipType):
        if self._isDAAPIInited():
            return self.flashObject.as_setPremShopData(iconSrc, premShopText, tooltip, tooltipType)

    def as_updateBattleTypeS(self, battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled, showLegacySelector, hasNew):
        if self._isDAAPIInited():
            return self.flashObject.as_updateBattleType(battleTypeName, battleTypeIcon, isEnabled, tooltip, tooltipType, battleTypeID, eventBgEnabled, eventAnimEnabled, showLegacySelector, hasNew)

    def as_setServerS(self, name, tooltip, tooltipType):
        if self._isDAAPIInited():
            return self.flashObject.as_setServer(name, tooltip, tooltipType)

    def as_updatePingStatusS(self, pingStatus, isColorBlind):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePingStatus(pingStatus, isColorBlind)

    def as_updateAnonymizedStateS(self, isAnonymized):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAnonymizedState(isAnonymized)

    def as_setWalletStatusS(self, walletStatus):
        if self._isDAAPIInited():
            return self.flashObject.as_setWalletStatus(walletStatus)

    def as_disableFightButtonS(self, isDisabled):
        if self._isDAAPIInited():
            return self.flashObject.as_disableFightButton(isDisabled)

    def as_setFightButtonS(self, label):
        if self._isDAAPIInited():
            return self.flashObject.as_setFightButton(label)

    def as_setCoolDownForReadyS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoolDownForReady(value)

    def as_showBubbleTooltipS(self, message, duration):
        if self._isDAAPIInited():
            return self.flashObject.as_showBubbleTooltip(message, duration)

    def as_setFightBtnTooltipS(self, tooltip, isSpecial):
        if self._isDAAPIInited():
            return self.flashObject.as_setFightBtnTooltip(tooltip, isSpecial)

    def as_updateOnlineCounterS(self, clusterStats, regionStats, tooltip, isAvailable):
        if self._isDAAPIInited():
            return self.flashObject.as_updateOnlineCounter(clusterStats, regionStats, tooltip, isAvailable)

    def as_initOnlineCounterS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_initOnlineCounter(visible)

    def as_setServerNameS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setServerName(value)

    def as_setHangarMenuDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHangarMenuData(data)

    def as_setButtonCounterS(self, btnAlias, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setButtonCounter(btnAlias, value)

    def as_removeButtonCounterS(self, btnAlias):
        if self._isDAAPIInited():
            return self.flashObject.as_removeButtonCounter(btnAlias)

    def as_setHeaderButtonsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeaderButtons(data)

    def as_hideMenuS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_hideMenu(value)

    def as_hideHeaderS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_hideHeader(value)

    def as_toggleVisibilityMenuS(self, state):
        if self._isDAAPIInited():
            return self.flashObject.as_toggleVisibilityMenu(state)

    def as_setIsPlatoonDropdownShowingS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsPlatoonDropdownShowing(visible)

    def as_setIsFullscreenBattleSelectorShowingS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsFullscreenBattleSelectorShowing(visible)

    def as_setButtonHighlightS(self, btnAlias, isHighlighted):
        if self._isDAAPIInited():
            return self.flashObject.as_setButtonHighlight(btnAlias, isHighlighted)

    def as_updateNYVisibilityS(self, isShowBattleBtnGlow):
        if self._isDAAPIInited():
            return self.flashObject.as_updateNYVisibility(isShowBattleBtnGlow)