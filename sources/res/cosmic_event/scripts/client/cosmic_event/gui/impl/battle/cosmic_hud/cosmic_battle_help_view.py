import CommandMapping
from cosmic_event.gui.impl import SCORE_EVENTS_TO_MODEL_ENUM
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.cosmic_battle_help_view_model import CosmicBattleHelpViewModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.scoring_model import ScoringModel
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event_common.cosmic_event_common import ScoreEvents
from frameworks.wulf import ViewFlags, ViewSettings, WindowFlags
from gui import InputHandler
from gui.impl.gen import R
from gui.impl.pub import ViewImpl, WindowImpl
from helpers import dependency

class CosmicBattleHelpView(ViewImpl):
    __cosmicBattleController = dependency.descriptor(ICosmicEventBattleController)
    __slots__ = ()

    def __init__(self, layoutID=R.views.cosmic_event.battle.cosmic_hud.CosmicBattleHelpView()):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.VIEW
        settings.model = CosmicBattleHelpViewModel()
        super(CosmicBattleHelpView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(CosmicBattleHelpView, self).getViewModel()

    def _initialize(self, *args, **kwargs):
        InputHandler.g_instance.onKeyUp += self.__handleKeyUpEvent
        cosmicSettings = self.__cosmicBattleController.getModeSettings()
        eventsConfig = cosmicSettings.scoreSystem.eventsConfig
        with self.viewModel.transaction() as (model):
            scoring = model.getScoring()
            scoring.reserve(len(SCORE_EVENTS_TO_MODEL_ENUM))
            for event, scoringType in SCORE_EVENTS_TO_MODEL_ENUM.iteritems():
                scoringModel = ScoringModel()
                if event == ScoreEvents.EVACUATION:
                    score = eventsConfig.getFirstPlaceEvacuationScore()
                else:
                    score = eventsConfig.getEventScore(event.name)
                scoringModel.setEventPoints(score)
                scoringModel.setType(scoringType)
                scoring.addViewModel(scoringModel)

        scoring.invalidate()

    def _finalize(self):
        InputHandler.g_instance.onKeyUp -= self.__handleKeyUpEvent

    def __handleKeyUpEvent(self, event):
        if CommandMapping.g_instance.isFired(CommandMapping.CMD_SHOW_HELP, event.key):
            self.destroyWindow()


class CosmicHelpWindow(WindowImpl):

    def __init__(self):
        super(CosmicHelpWindow, self).__init__(wndFlags=WindowFlags.WINDOW | WindowFlags.WINDOW_FULLSCREEN, content=CosmicBattleHelpView())