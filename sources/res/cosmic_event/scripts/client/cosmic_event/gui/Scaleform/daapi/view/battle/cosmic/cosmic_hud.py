import logging, typing, BigWorld
from cosmic_event.gui.impl.battle.cosmic_hud.cosmic_hud_view import CosmicHudView
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.battle_control.controllers.battle_hints.component import BattleHintComponent
from gui.battle_control.controllers.period_ctrl import IAbstractPeriodView
from gui.impl.gen import R
from constants import ARENA_PERIOD
from hints.battle.schemas.base import CHMType
from helpers import dependency
from skeletons.gui.impl import IGuiLoader
from skeletons.gui.battle_session import IBattleSessionProvider
if typing.TYPE_CHECKING:
    from gui.battle_control.controllers.battle_hints.queues import BattleHintQueueParams
_logger = logging.getLogger(__name__)

class CosmicHud(InjectComponentAdaptor, IAbstractPeriodView):
    _sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def _makeInjectView(self):
        return CosmicHudView()

    def setPeriod(self, period):
        self.getInjectView().setPeriod(period)
        if period == ARENA_PERIOD.WAITING:
            self._sessionProvider.dynamic.battleHints.showHint('cosmic.await_for_players', {})
        if period == ARENA_PERIOD.PREBATTLE:
            self._sessionProvider.dynamic.battleHints.hideHint('cosmic.await_for_players')
            periodCtrl = self._sessionProvider.shared.arenaPeriod
            remainingTime = periodCtrl.getEndTime() - BigWorld.serverTime()
            self._sessionProvider.dynamic.battleHints.showHint('cosmic.prebattle', {'overrideShowTime': remainingTime})
        if period == ARENA_PERIOD.BATTLE:
            self._sessionProvider.dynamic.battleHints.hideHint('cosmic.prebattle')
            self._sessionProvider.dynamic.battleHints.showHint('cosmic_voice.battle', {})
        if period == ARENA_PERIOD.AFTERBATTLE:
            self._sessionProvider.dynamic.battleHints.showHint('cosmic.mission_complete', {})


class CosmicHintsPlayer(BattleHintComponent):
    COSMIC_HUD_R = R.views.cosmic_event.battle.cosmic_hud.CosmicReactHudView()
    gui = dependency.descriptor(IGuiLoader)

    def __init__(self, alias, queueParams):
        super(CosmicHintsPlayer, self).__init__(queueParams)
        self._alias = alias

    def getAlias(self):
        return self._alias

    @property
    def cosmicHud(self):
        return self.gui.windowsManager.getViewByLayoutID(self.COSMIC_HUD_R)


class CosmicVoiceHintsPlayer(CosmicHintsPlayer):

    def _showHint(self, model, params):
        self.cosmicHud.showVoiceHint(model, params)

    def _hideHint(self):
        self.cosmicHud.hideVoiceHint()


class CosmicTextHintsPlayer(CosmicHintsPlayer):

    def _showHint(self, model, params):
        self.cosmicHud.showTextHint(model, params)

    def _hideHint(self):
        self.cosmicHud.hideTextHint()