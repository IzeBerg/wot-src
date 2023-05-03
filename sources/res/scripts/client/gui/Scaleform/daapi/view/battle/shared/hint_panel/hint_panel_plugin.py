from collections import namedtuple
from datetime import datetime
from helpers import time_utils
from account_helpers.AccountSettings import HINTS_LEFT, NUM_BATTLES, LAST_DISPLAY_DAY
from gui.shared.utils.plugins import IPlugin
_HINT_DISPLAY_COUNT_AFTER_RESET = 1

class HintPriority(object):
    DYN_SQUAD = 0
    TRAJECTORY = 1
    HELP = 2
    MAPBOX = 3
    BATTLE_COMMUNICATION = 4
    QUESTS = 5
    RESERVES = 6
    RADAR = 7
    SIEGE = 8


class HelpHintContext(object):
    MECHANICS = 'mechanics'
    ROLE_HELP = 'roleHelp'
    MAPS_TRAINING = 'mapsTraining'
    MAPBOX = 'mapbox'
    BATTLE_ROYALE = 'battleRoyale'
    COMMANDER_CAMERA = 'commanderCamera'


HintData = namedtuple('HintData', ('vKey', 'key', 'messageLeft', 'messageRight', 'offsetX',
                                   'offsetY', 'priority', 'reducedPanning', 'hintCtx'))
HintData.__new__.__defaults__ = ('', '', '', '', 0, 0, HintPriority.HELP, False, None)

class HintPanelPlugin(IPlugin):
    __slots__ = ()

    @classmethod
    def isSuitable(cls):
        raise NotImplementedError

    def setPeriod(self, period):
        pass

    def updateMapping(self):
        pass

    def _getHint(self):
        return

    @staticmethod
    def _updateCounterOnUsed(settings):
        if settings:
            settings[LAST_DISPLAY_DAY] = datetime.now().timetuple().tm_yday
            settings[NUM_BATTLES] = 0
            settings[HINTS_LEFT] = max(0, settings[HINTS_LEFT] - 1)
        return settings

    @staticmethod
    def _updateBattleCounterOnUsed(settings):
        if settings:
            settings[HINTS_LEFT] = max(0, settings[HINTS_LEFT] - 1)
        return settings

    @staticmethod
    def _updateCounterOnStart(setting, dayCoolDown, battleCoolDown):
        if not setting:
            return
        hintsLeft = setting[HINTS_LEFT]
        numBattles = setting[NUM_BATTLES]
        lastDayOfYear = setting[LAST_DISPLAY_DAY]
        dayOfYear = datetime.now().timetuple().tm_yday
        daysLeft = (dayOfYear - lastDayOfYear + time_utils.DAYS_IN_YEAR) % time_utils.DAYS_IN_YEAR
        if hintsLeft == 0 and (daysLeft >= dayCoolDown or numBattles >= battleCoolDown):
            setting[HINTS_LEFT] = _HINT_DISPLAY_COUNT_AFTER_RESET

    @classmethod
    def _updateCounterOnBattle(cls, setting):
        if setting and not cls._haveHintsLeft(setting):
            setting[NUM_BATTLES] = setting[NUM_BATTLES] + 1

    @staticmethod
    def _haveHintsLeft(setting):
        if not setting:
            return False
        return setting[HINTS_LEFT] > 0