from gui.Scaleform.daapi.view.meta.BCBattleTopHintMeta import BCBattleTopHintMeta
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.Scaleform.genConsts.BATTLE_TOP_HINT_CONSTS import BATTLE_TOP_HINT_CONSTS
from bootcamp.BootCampEvents import g_bootcampEvents
from bootcamp.BootcampConstants import HINT_TYPE
from uilogging.deprecated.decorators import loggerTarget, loggerEntry, logOnMatch
from uilogging.deprecated.bootcamp.constants import BC_LOG_KEYS, BATTLE_HINTS_TO_LOG_ON_COMPLETE, BATTLE_HINTS_TO_LOG_ON_HIDE, BATTLE_HINTS_TO_LOG_ON_ANIMATION_FINISH
from uilogging.deprecated.bootcamp.loggers import BootcampUILogger
HINT_TYPE_TO_FRAME = {HINT_TYPE.HINT_MOVE: BATTLE_TOP_HINT_CONSTS.FRAME_WASD, 
   HINT_TYPE.HINT_MOVE_TURRET: BATTLE_TOP_HINT_CONSTS.FRAME_MOUSE_MOVE, 
   HINT_TYPE.HINT_SHOOT: BATTLE_TOP_HINT_CONSTS.FRAME_MOUSE_CLICK, 
   HINT_TYPE.HINT_SNIPER: BATTLE_TOP_HINT_CONSTS.FRAME_MOUSE_SCROLL, 
   HINT_TYPE.HINT_SNIPER_LEVEL0: BATTLE_TOP_HINT_CONSTS.FRAME_MOUSE_SCROLL, 
   HINT_TYPE.HINT_ADVANCED_SNIPER: BATTLE_TOP_HINT_CONSTS.FRAME_MOUSE_SCROLL, 
   HINT_TYPE.HINT_WEAK_POINTS: BATTLE_TOP_HINT_CONSTS.FRAME_PENETRATION, 
   HINT_TYPE.HINT_MESSAGE_AVOID: BATTLE_TOP_HINT_CONSTS.FRAME_AVOID_ENEMY, 
   HINT_TYPE.HINT_REPAIR_TRACK: BATTLE_TOP_HINT_CONSTS.FRAME_DETRACK, 
   HINT_TYPE.HINT_HEAL_CREW: BATTLE_TOP_HINT_CONSTS.FRAME_CREW, 
   HINT_TYPE.HINT_USE_EXTINGUISHER: BATTLE_TOP_HINT_CONSTS.FRAME_FIRE, 
   HINT_TYPE.HINT_SNIPER_ON_DISTANCE: BATTLE_TOP_HINT_CONSTS.FRAME_MOUSE_SCROLL, 
   HINT_TYPE.HINT_B3_YOU_ARE_DETECTED: BATTLE_TOP_HINT_CONSTS.FRAME_SIXTH_SENSE, 
   HINT_TYPE.HINT_B3_FALL_BACK: BATTLE_TOP_HINT_CONSTS.FRAME_DOMINANCE, 
   HINT_TYPE.HINT_B3_FOLIAGE: BATTLE_TOP_HINT_CONSTS.FRAME_HIDING, 
   HINT_TYPE.HINT_B3_DO_CAPTURE: BATTLE_TOP_HINT_CONSTS.FRAME_BASE_CAPTURE, 
   HINT_TYPE.HINT_B3_FOLIAGE2: BATTLE_TOP_HINT_CONSTS.FRAME_HIDING_SHOOTING, 
   HINT_TYPE.HINT_B3_FLANK: BATTLE_TOP_HINT_CONSTS.FRAME_GO_FLANG, 
   HINT_TYPE.HINT_B3_CAPTURE_IN_PROGRESS: BATTLE_TOP_HINT_CONSTS.FRAME_BASE_APPEAR, 
   HINT_TYPE.HINT_B3_CAPTURE_RESET: BATTLE_TOP_HINT_CONSTS.FRAME_BASE_PROGRESS, 
   HINT_TYPE.HINT_RTS_MOVE_TANK: BATTLE_TOP_HINT_CONSTS.FRAME_MOVE_TANK, 
   HINT_TYPE.HINT_RTS_ATTACK_TANK: BATTLE_TOP_HINT_CONSTS.FRAME_ATTACK_TANK, 
   HINT_TYPE.HINT_RTS_ATTACK_TANK_DOUBLE_CLICK: BATTLE_TOP_HINT_CONSTS.FRAME_ATTACK_TANK_DOUBLE_CLICK, 
   HINT_TYPE.HINT_RTS_CONTROL_TANK: BATTLE_TOP_HINT_CONSTS.FRAME_CONTROL_TANK, 
   HINT_TYPE.HINT_RTS_RELEASE_TANK: BATTLE_TOP_HINT_CONSTS.FRAME_RELEASE_TANK, 
   HINT_TYPE.HINT_RTS_MULTISELECT_TANKS: BATTLE_TOP_HINT_CONSTS.FRAME_MULTISELECT_TANKS, 
   HINT_TYPE.HINT_RTS_SUPPLIES: BATTLE_TOP_HINT_CONSTS.FRAME_RTS_SUPPLIES, 
   HINT_TYPE.HINT_RTS_ROTATE_CAMERA: BATTLE_TOP_HINT_CONSTS.FRAME_RTS_ROTATE_CAMERA}
HINT_VISIBILITY_COMPONENTS_MAP = {HINT_TYPE.HINTS_B3_CAPTURE: BATTLE_VIEW_ALIASES.TEAM_BASES_PANEL, 
   HINT_TYPE.HINTS_B3_DETECTED: BATTLE_VIEW_ALIASES.SIXTH_SENSE}

@loggerTarget(logKey=BC_LOG_KEYS.BC_BATTLE_HINTS, loggerCls=BootcampUILogger)
class BCBattleTopHint(BCBattleTopHintMeta):

    def __init__(self):
        super(BCBattleTopHint, self).__init__()
        self.__hideCallback = None
        self.__id = None
        self.__message = None
        self.__completed = None
        self.__componentName = None
        self.__frameId = None
        return

    @loggerEntry
    def showHint(self, settings):
        self.__hideCallback = settings['hideCallback']
        self.__id = settings['id']
        self.__frameId = HINT_TYPE_TO_FRAME.get(self.__id, BATTLE_TOP_HINT_CONSTS.FRAME_EMPTY)
        self.__message = settings['message']
        self.__completed = settings['completed']
        self.as_showHintS(self.__frameId, self.__message, self.__completed)
        for group, name in HINT_VISIBILITY_COMPONENTS_MAP.iteritems():
            if self.__id in group:
                self.__componentName = name
                g_bootcampEvents.onBattleComponentVisibility(self.__componentName, False)
                break

    @property
    def hintID(self):
        return self.__id

    @logOnMatch(objProperty='hintID', matches=BATTLE_HINTS_TO_LOG_ON_ANIMATION_FINISH)
    def animFinish(self):
        if self.__hideCallback is not None:
            self.__hideCallback()
            self.__hideCallback = None
        return

    @logOnMatch(objProperty='hintID', matches=BATTLE_HINTS_TO_LOG_ON_COMPLETE)
    def complete(self):
        if self.__id is not None and self.__message is not None:
            self.as_showHintS(self.__frameId, self.__message, True)
        return

    @logOnMatch(objProperty='hintID', matches=BATTLE_HINTS_TO_LOG_ON_HIDE)
    def hideHint(self):
        self.as_hideHintS()
        if self.__componentName is not None:
            g_bootcampEvents.onBattleComponentVisibility(self.__componentName, True)
        return

    def closeHint(self):
        self.as_closeHintS()
        self.__hideCallback = None
        if self.__componentName is not None:
            g_bootcampEvents.onBattleComponentVisibility(self.__componentName, True)
        return