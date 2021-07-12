from gui.Scaleform.daapi.view.meta.WrapperViewMeta import WrapperViewMeta

class BadgesPageMeta(WrapperViewMeta):

    def onBackClick(self):
        self._printOverrideError('onBackClick')

    def onSelectBadge(self, badgeID):
        self._printOverrideError('onSelectBadge')

    def onDeselectBadge(self):
        self._printOverrideError('onDeselectBadge')

    def onSelectSuffixBadge(self, badgeID):
        self._printOverrideError('onSelectSuffixBadge')

    def onDeselectSuffixBadge(self):
        self._printOverrideError('onDeselectSuffixBadge')

    def onDummyButtonPress(self):
        self._printOverrideError('onDummyButtonPress')

    def as_setStaticDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setStaticData(data)

    def as_setReceivedBadgesS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setReceivedBadges(data)

    def as_setNotReceivedBadgesS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setNotReceivedBadges(data)

    def as_setSelectedBadgeS(self, data, selected):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelectedBadge(data, selected)

    def as_setBadgeSuffixS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setBadgeSuffix(data)