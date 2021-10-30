from constants import PREBATTLE_TYPE
from gui.prb_control import prb_getters
from gui.prb_control.factories.ControlFactory import ControlFactory
from gui.prb_control.entities.base.legacy.ctx import LeaveLegacyCtx
from gui.prb_control.entities.base.legacy.entity import LegacyIntroEntryPoint, LegacyInitEntity, LegacyIntroEntity
from gui.prb_control.entities.epic_battle_training.entity import EpicBattleTrainingEntryPoint, EpicBattleTrainingIntroEntryPoint, EpicBattleTrainingEntity, EpicBattleTrainingIntroEntity
from gui.prb_control.entities.battle_session.legacy.entity import BattleSessionEntryPoint, BattleSessionListEntryPoint, BattleSessionEntity
from gui.prb_control.entities.training.legacy.entity import TrainingEntryPoint, TrainingIntroEntryPoint, TrainingEntity, TrainingIntroEntity
from gui.prb_control.entities.battle_royale_tournament.legacy.entity import BattleRoyaleTournamentEntryPoint
from gui.prb_control.items import PlayerDecorator, FunctionalState
from gui.prb_control.settings import FUNCTIONAL_FLAG, PREBATTLE_ACTION_NAME, CTRL_ENTITY_TYPE
__all__ = ('LegacyFactory', )
_SUPPORTED_ENTRY_BY_TYPE = {PREBATTLE_TYPE.TRAINING: TrainingEntryPoint, 
   PREBATTLE_TYPE.TOURNAMENT: BattleSessionEntryPoint, 
   PREBATTLE_TYPE.CLAN: BattleSessionEntryPoint, 
   PREBATTLE_TYPE.EPIC_TRAINING: EpicBattleTrainingEntryPoint, 
   PREBATTLE_TYPE.BATTLE_ROYALE_TOURNAMENT: BattleRoyaleTournamentEntryPoint}
_SUPPORTED_ENTRY_BY_ACTION = {PREBATTLE_ACTION_NAME.TRAININGS_LIST: TrainingIntroEntryPoint, 
   PREBATTLE_ACTION_NAME.SPEC_BATTLES_LIST: BattleSessionListEntryPoint, 
   PREBATTLE_ACTION_NAME.EPIC_TRAINING_LIST: EpicBattleTrainingIntroEntryPoint}
_SUPPORTED_ENTITY = {PREBATTLE_TYPE.TRAINING: TrainingEntity, 
   PREBATTLE_TYPE.TOURNAMENT: BattleSessionEntity, 
   PREBATTLE_TYPE.CLAN: BattleSessionEntity, 
   PREBATTLE_TYPE.EPIC_TRAINING: EpicBattleTrainingEntity}
_SUPPORTED_INTRO_BY_TYPE = {PREBATTLE_TYPE.TRAINING: TrainingIntroEntity, 
   PREBATTLE_TYPE.EPIC_TRAINING: EpicBattleTrainingIntroEntity}

class LegacyFactory(ControlFactory):

    def createEntry(self, ctx):
        if not ctx.getRequestType():
            return LegacyIntroEntryPoint(FUNCTIONAL_FLAG.UNDEFINED, ctx.getEntityType())
        else:
            prbType = ctx.getEntityType()
            if prbType in _SUPPORTED_ENTRY_BY_TYPE:
                return _SUPPORTED_ENTRY_BY_TYPE[prbType]()
            return

    def createEntryByAction(self, action):
        return self._createEntryByAction(action, _SUPPORTED_ENTRY_BY_ACTION)

    def createEntity(self, ctx):
        if ctx.getCtrlType() == CTRL_ENTITY_TYPE.LEGACY:
            created = self.__createByAccountState(ctx)
        else:
            created = self.__createByFlags(ctx)
        return created

    def createPlayerInfo(self, entity):
        info = entity.getPlayerInfo()
        return PlayerDecorator(info.isCreator, info.isReady())

    def createStateEntity(self, entity):
        return FunctionalState(CTRL_ENTITY_TYPE.LEGACY, entity.getEntityType(), True, entity.hasLockedState(), isinstance(entity, LegacyIntroEntity), funcFlags=entity.getFunctionalFlags())

    def createLeaveCtx(self, flags=FUNCTIONAL_FLAG.UNDEFINED, entityType=0):
        return LeaveLegacyCtx(waitingID='prebattle/leave', flags=flags, entityType=entityType)

    def __createByAccountState(self, ctx):
        clientPrb = prb_getters.getClientPrebattle()
        if clientPrb is not None:
            if prb_getters.isPrebattleSettingsReceived(prebattle=clientPrb):
                prbSettings = prb_getters.getPrebattleSettings(prebattle=clientPrb)
                prbType = prb_getters.getPrebattleType(settings=prbSettings)
                clazz = None
                if prbType in _SUPPORTED_ENTITY:
                    clazz = _SUPPORTED_ENTITY[prbType]
                if clazz:
                    return clazz(prbSettings)
            else:
                return LegacyInitEntity()
        return self.__createByPrbType(ctx)

    def __createByFlags(self, ctx):
        if not ctx.hasFlags(FUNCTIONAL_FLAG.LEGACY):
            return self.__createByAccountState(ctx)
        else:
            return

    def __createByPrbType(self, ctx):
        if ctx.getCtrlType() != CTRL_ENTITY_TYPE.LEGACY:
            return
        else:
            prbType = ctx.getEntityType()
            if prbType in _SUPPORTED_INTRO_BY_TYPE:
                return self._createEntityByType(prbType, _SUPPORTED_INTRO_BY_TYPE)
            return