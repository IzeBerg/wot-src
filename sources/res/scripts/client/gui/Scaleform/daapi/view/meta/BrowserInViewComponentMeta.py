from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BrowserInViewComponentMeta(BaseDAAPIComponent):

    def viewSize(self, width, height):
        self._printOverrideError('viewSize')

    def as_loadBrowserS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_loadBrowser()

    def as_setTitleS(self, title):
        if self._isDAAPIInited():
            return self.flashObject.as_setTitle(title)