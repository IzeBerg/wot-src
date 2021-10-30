from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class CursorManagerMeta(BaseDAAPIComponent):

    def as_setCursorS(self, cursor):
        if self._isDAAPIInited():
            return self.flashObject.as_setCursor(cursor)