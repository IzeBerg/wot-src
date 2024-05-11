from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class ProfileTabNavigatorMeta(BaseDAAPIComponent):

    def onTabChange(self, tabId):
        self._printOverrideError('onTabChange')

    def onViewReady(self, alias):
        self._printOverrideError('onViewReady')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_setBtnTabCountersS(self, counters):
        if self._isDAAPIInited():
            return self.flashObject.as_setBtnTabCounters(counters)