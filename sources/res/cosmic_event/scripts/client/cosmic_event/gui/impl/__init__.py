from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.scoring_model import ScoringTypeEnum
from cosmic_event_common.cosmic_event_common import ScoreEvents
SCORE_EVENTS_TO_MODEL_ENUM = {ScoreEvents.KILL: ScoringTypeEnum.KILL, 
   ScoreEvents.ABILITY_PICKUP: ScoringTypeEnum.ABILITYPICKUP, 
   ScoreEvents.KILL_ASSIST: ScoringTypeEnum.KILLASSIST, 
   ScoreEvents.RAMMING: ScoringTypeEnum.RAM, 
   ScoreEvents.SHOT: ScoringTypeEnum.SHOT, 
   ScoreEvents.ABILITY_HIT: ScoringTypeEnum.ABILITYHIT, 
   ScoreEvents.FRAGMENT_PICKUP: ScoringTypeEnum.FRAGMENTPICKUP, 
   ScoreEvents.FRAGMENT_CARRYING: ScoringTypeEnum.FRAGMENTCARRYING, 
   ScoreEvents.FRAGMENT_HOLDER_KILL: ScoringTypeEnum.FRAGMENTHOLDERKILL, 
   ScoreEvents.FRAGMENT_DELIVERING: ScoringTypeEnum.FRAGMENTDELIVERING, 
   ScoreEvents.EVACUATION: ScoringTypeEnum.EVACUATION}