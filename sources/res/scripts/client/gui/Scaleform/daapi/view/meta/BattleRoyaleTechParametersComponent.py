from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleRoyaleTechParametersComponent(BaseDAAPIComponent):

    def as_updateHeightS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateHeight(value)