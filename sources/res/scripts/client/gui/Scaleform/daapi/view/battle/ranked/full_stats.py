from gui.Scaleform.daapi.view.battle.shared.tabbed_full_stats import TabbedFullStatsComponent

class FullStatsComponent(TabbedFullStatsComponent):

    @staticmethod
    def _buildTabs(builder):
        builder.addStatisticsTab()
        builder.addBoostersTab()
        return builder.getTabs()