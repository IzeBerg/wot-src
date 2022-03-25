from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CommanderHelpMeta(BaseDAAPIComponent):

    def onOrderButtonClicked(self, keyCode):
        self._printOverrideError('onOrderButtonClicked')

    def as_setOrderItemsS(self, orderItems):
        if self._isDAAPIInited():
            return self.flashObject.as_setOrderItems(orderItems)

    def as_updateOrderStateS(self, idx, isActive, isPressed, isDisabled):
        if self._isDAAPIInited():
            return self.flashObject.as_updateOrderState(idx, isActive, isPressed, isDisabled)