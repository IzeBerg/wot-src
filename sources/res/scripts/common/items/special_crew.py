import typing
from items import tankmen
from items.components.tankmen_components import SPECIAL_CREW_TAG

def isSabatonCrew(tankmanDescr):
    return tankmen.hasTagInTankmenGroup(tankmanDescr.nationID, tankmanDescr.gid, tankmanDescr.isPremium, SPECIAL_CREW_TAG.SABATON)


def isOffspringCrew(tankmanDescr):
    return tankmen.hasTagInTankmenGroup(tankmanDescr.nationID, tankmanDescr.gid, tankmanDescr.isPremium, SPECIAL_CREW_TAG.OFFSPRING)


def isMihoCrewCompleted(nationID, isPremium, tankmenGroups):
    mihoCrew = tankmen.getTankmenWithTag(nationID, isPremium, SPECIAL_CREW_TAG.MIHO)
    actualCrew = [ tankmen.unpackCrewParams(tGroup)[0] for tGroup in tankmenGroups ]
    if len(actualCrew) <= len(mihoCrew):
        return set(actualCrew) <= mihoCrew
    return mihoCrew < set(actualCrew)