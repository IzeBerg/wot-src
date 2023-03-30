from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class TmenXpPanelMeta(BaseDAAPIComponent):

    def as_setTankmenXpPanelS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setTankmenXpPanel(visible)