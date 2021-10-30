from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class ChannelsManagementWindowMeta(AbstractWindowView):

    def getSearchLimitLabel(self):
        self._printOverrideError('getSearchLimitLabel')

    def searchToken(self, token):
        self._printOverrideError('searchToken')

    def joinToChannel(self, index):
        self._printOverrideError('joinToChannel')

    def createChannel(self, name, usePassword, password, retype):
        self._printOverrideError('createChannel')

    def as_hideChannelNameInputS(self, isHide):
        if self._isDAAPIInited():
            return self.flashObject.as_hideChannelNameInput(isHide)

    def as_freezSearchButtonS(self, isEnable):
        if self._isDAAPIInited():
            return self.flashObject.as_freezSearchButton(isEnable)

    def as_getDataProviderS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getDataProvider()