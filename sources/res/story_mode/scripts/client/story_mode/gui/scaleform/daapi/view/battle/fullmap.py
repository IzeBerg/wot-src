import BattleReplay
from gui.Scaleform.daapi.view.battle.pve_base.fullmap import PveFullMapComponent
from story_mode.gui.scaleform.daapi.view.battle.minimap import BunkersPlugin, adjustBoundingBox, StoryModeMinimapPingPlugin

class StoryModeFullMapComponent(PveFullMapComponent):

    def _setupPlugins(self, arenaVisitor):
        setup = super(StoryModeFullMapComponent, self)._setupPlugins(arenaVisitor)
        setup['bunkers'] = BunkersPlugin
        if not BattleReplay.g_replayCtrl.isPlaying:
            setup['pinging'] = StoryModeMinimapPingPlugin
        return setup

    def getBoundingBox(self):
        arenaVisitor = self.sessionProvider.arenaVisitor
        return adjustBoundingBox(*arenaVisitor.type.getBoundingBox())