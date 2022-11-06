from gui.Scaleform.framework.entities.View import View

class SubtitlesWindowMeta(View):

    def as_showSubtitleS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_showSubtitle(text)

    def as_hideSubtitleS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideSubtitle()