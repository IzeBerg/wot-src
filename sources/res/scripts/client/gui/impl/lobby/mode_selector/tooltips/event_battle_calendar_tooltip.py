from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.mode_selector.tooltips.event_battle_calendar_tooltip_model import EventBattleCalendarTooltipModel
from gui.impl.pub import ViewImpl
from helpers import dependency
from skeletons.gui.game_control import IEventBattlesController

class EventBattleCalendarTooltip(ViewImpl):
    __eventBattleCtrl = dependency.descriptor(IEventBattlesController)

    def __init__(self):
        settings = ViewSettings(R.views.lobby.mode_selector.tooltips.EventCalendarTooltip(), model=EventBattleCalendarTooltipModel())
        super(EventBattleCalendarTooltip, self).__init__(settings)

    def _onLoading(self, *args, **kwargs):
        model = self.getViewModel()
        progressCtrl = self.__eventBattleCtrl.getHWProgressCtrl()
        if progressCtrl:
            phases = progressCtrl.phasesHalloween
            regularPhases = phases.getPhasesByType(phaseType=1)
            regulaPhasesCount = len(regularPhases)
            lastRugularPhase = regularPhases[(-1)] if regulaPhasesCount > 0 else None
            firstRugularPhase = regularPhases[0] if regulaPhasesCount > 0 else None
            postPhase = phases.getPhaseByIndex(phases.getCountPhases())
            if firstRugularPhase and postPhase:
                model.setStartDate(firstRugularPhase.getStartTime())
                model.setEndEventDate(postPhase.getFinishTime())
            if lastRugularPhase:
                model.setEndActivePhaseDate(lastRugularPhase.getFinishTime())
        return