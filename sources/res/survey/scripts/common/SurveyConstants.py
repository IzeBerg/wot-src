from enum import IntEnum
CMD_SURVEY_RES = 31001

class SURVEY_ANSWERS(IntEnum):
    CANCELED = -3
    WORST = -2
    BAD = -1
    NEUTRAL = 0
    GOOD = 1
    BEST = 2