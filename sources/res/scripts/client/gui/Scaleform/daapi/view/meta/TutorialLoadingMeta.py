from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class TutorialLoadingMeta(BaseDAAPIComponent):

    def as_setTutorialArenaInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTutorialArenaInfo(data)