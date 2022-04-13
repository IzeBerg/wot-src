from frameworks.wulf import ViewModel

class ModeSelectorTooltipsConstants(ViewModel):
    __slots__ = ()
    DISABLED_TOOLTIP = 'disabledTooltip'
    RANDOM_BP_PAUSED_TOOLTIP = 'randomBPPausedTooltip'
    RANKED_CALENDAR_DAY_INFO_TOOLTIP = 'rankedCalendarDayInfoExtended'
    RANKED_STEP_TOOLTIP = 'rankedStep'
    RANKED_BATTLES_RANK_TOOLTIP = 'rankedBattlesRank'
    RANKED_BATTLES_BONUS_TOOLTIP = 'rankedBattlesBonus'
    RANKED_BATTLES_LEAGUE_TOOLTIP = 'rankedBattlesLeague'
    RANKED_BATTLES_EFFICIENCY_TOOLTIP = 'rankedBattlesEfficiency'
    RANKED_BATTLES_POSITION_TOOLTIP = 'rankedBattlesPosition'
    CALENDAR_TOOLTIP = 'calendarTooltip'
    MAPBOX_CALENDAR_TOOLTIP = 'mapboxCalendar'
    EPIC_BATTLE_CALENDAR_TOOLTIP = 'epicBattleCalendarTooltip'
    RTS_CALENDAR_TOOLTIP = 'rtsSelectorInfo'

    def __init__(self, properties=0, commands=0):
        super(ModeSelectorTooltipsConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ModeSelectorTooltipsConstants, self)._initialize()