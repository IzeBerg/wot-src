from gui.Scaleform.daapi.view.battle.classic.full_stats import FullStatsComponent

class WinbackFullStatsComponent(FullStatsComponent):

    @staticmethod
    def _buildTabs(builder):
        builder.addStatisticsTab()
        builder.addBoostersTab()
        return builder.getTabs()