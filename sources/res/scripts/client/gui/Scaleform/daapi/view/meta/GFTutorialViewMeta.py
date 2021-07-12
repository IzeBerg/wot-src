from gui.Scaleform.framework.entities.View import View

class GFTutorialViewMeta(View):

    def as_createHintAreaInComponentS(self, componentName, hintName, posX, posY, width, height):
        if self._isDAAPIInited():
            return self.flashObject.as_createHintAreaInComponent(componentName, hintName, posX, posY, width, height)

    def as_removeHintAreaS(self, hintName):
        if self._isDAAPIInited():
            return self.flashObject.as_removeHintArea(hintName)