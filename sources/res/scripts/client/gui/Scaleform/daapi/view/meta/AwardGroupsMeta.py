from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class AwardGroupsMeta(BaseDAAPIComponent):

    def showGroup(self, groupId):
        self._printOverrideError('showGroup')

    def as_setDataS(self, groups):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(groups)

    def as_setTooltipsS(self, tooltips):
        if self._isDAAPIInited():
            return self.flashObject.as_setTooltips(tooltips)

    def as_setSelectedS(self, id, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSelected(id, value)

    def as_setEnabledS(self, id, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setEnabled(id, value)