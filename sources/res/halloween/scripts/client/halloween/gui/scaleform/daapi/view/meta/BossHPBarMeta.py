from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BossHPBarMeta(BaseDAAPIComponent):

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)

    def as_setMaxLivesS(self, value, difficulty):
        if self._isDAAPIInited():
            return self.flashObject.as_setMaxLives(value, difficulty)

    def as_setLivesS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setLives(value)

    def as_setBossHPS(self, label, progress):
        if self._isDAAPIInited():
            return self.flashObject.as_setBossHP(label, progress)