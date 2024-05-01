import enum

@enum.unique
class ScoreEvents(enum.IntEnum):
    SHOT = 1
    RAMMING = 2
    KILL = 3
    ABILITY_PICKUP = 4
    ABILITY_HIT = 5
    FRAGMENT_PICKUP = 6
    FRAGMENT_CARRYING = 7
    KILL_ASSIST = 8
    FRAGMENT_DELIVERING = 9
    FRAGMENT_HOLDER_KILL = 10
    EVACUATION = 11


SEQUENTIAL_SCORE_EVENTS = (
 ScoreEvents.EVACUATION,)
ONCE_PER_VEHICLE_EVENTS = (
 ScoreEvents.EVACUATION,)

@enum.unique
class ImpulseType(enum.IntEnum):
    BOUNDARY = 1
    RAM = 2
    SHOT = 3
    BOOSTER = 4
    VORTEX = 5
    JUMP = 6
    REPULSOR = 7


@enum.unique
class Abilities(enum.IntEnum):
    VORTEX = 1
    REPULSOR = 2
    MINE = 3
    JUMP = 4


def checkIfViolator(avatarResults):
    fairplayState = avatarResults.get('fairplayViolations', (0, 0, 0))
    return fairplayState[1] != 0