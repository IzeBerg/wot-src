from gui.Scaleform.daapi.view.battle.pve_base.ribbons_panel import PveRibbonsPanel
from story_mode.gui.scaleform.daapi.view.battle import ribbons_aggregator

class StoryModeRibbonsPanel(PveRibbonsPanel):

    def __init__(self):
        super(StoryModeRibbonsPanel, self).__init__(ribbonsAggregator=ribbons_aggregator.createRibbonsAggregator())