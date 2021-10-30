from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehModulesConfiguratorCmpMeta(BaseDAAPIComponent):

    def onClick(self, intCD, columnIdx, moduleIdx):
        self._printOverrideError('onClick')

    def as_setItemsS(self, items):
        if self._isDAAPIInited():
            return self.flashObject.as_setItems(items)

    def as_updateItemsS(self, items):
        if self._isDAAPIInited():
            return self.flashObject.as_updateItems(items)