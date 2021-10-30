import typing
from items import tankmen
from items.components.tankmen_components import SPECIAL_CREW_TAG

def isSabatonCrew(tankmanDescr):
    return _hasTagInTankmenGroup(tankmanDescr, SPECIAL_CREW_TAG.SABATON)


def isOffspringCrew(tankmanDescr):
    return _hasTagInTankmenGroup(tankmanDescr, SPECIAL_CREW_TAG.OFFSPRING)


def isYhaCrew(tankmanDescr):
    return _hasTagInTankmenGroup(tankmanDescr, SPECIAL_CREW_TAG.YHA)


def isMihoCrewCompleted(nationID, isPremium, tankmenGroups):
    return _isCrewCompleted(nationID, isPremium, tankmenGroups, SPECIAL_CREW_TAG.MIHO)


def isYhaCrewCompleted(nationID, isPremium, tankmenGroups):
    return _isCrewCompleted(nationID, isPremium, tankmenGroups, SPECIAL_CREW_TAG.YHA)


def _hasTagInTankmenGroup(tankmanDescr, tag):
    return tankmen.hasTagInTankmenGroup(tankmanDescr.nationID, tankmanDescr.gid, tankmanDescr.isPremium, tag)


def _isCrewCompleted(nationID, isPremium, tankmenGroups, tag):
    requiredCrew = tankmen.getTankmenWithTag(nationID, isPremium, tag)
    actualCrew = [ tankmen.unpackCrewParams(tGroup)[0] for tGroup in tankmenGroups ]
    if len(actualCrew) <= len(requiredCrew):
        return set(actualCrew) <= requiredCrew
    return requiredCrew < set(actualCrew)