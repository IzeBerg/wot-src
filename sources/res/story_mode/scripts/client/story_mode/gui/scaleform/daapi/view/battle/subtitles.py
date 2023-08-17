from helpers import dependency
from story_mode.gui.scaleform.daapi.view.meta.StoryModeSubtitlesMeta import StoryModeSubtitlesMeta
from story_mode.skeletons.voiceover_controller import IVoiceoverManager

class BattleSubtitles(StoryModeSubtitlesMeta):
    _voiceoverManager = dependency.descriptor(IVoiceoverManager)

    def _populate(self):
        super(BattleSubtitles, self)._populate()
        self._voiceoverManager.onSubtitleShow += self._showSubtitleHandler
        self._voiceoverManager.onSubtitleHide += self._hideSubtitleHandler
        if self._voiceoverManager.currentSubtitle:
            self.as_showS(self._voiceoverManager.currentSubtitle)

    def _destroy(self):
        super(BattleSubtitles, self)._destroy()
        self._voiceoverManager.onSubtitleShow -= self._showSubtitleHandler
        self._voiceoverManager.onSubtitleHide -= self._hideSubtitleHandler

    def _showSubtitleHandler(self):
        self.as_showS(self._voiceoverManager.currentSubtitle)

    def _hideSubtitleHandler(self):
        self.as_hideS()