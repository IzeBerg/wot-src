from abstract import RegularAchievement
from abstract.mixins import NoProgressBar
from dossiers2.ui.achievements import ACHIEVEMENT_BLOCK as _AB
from gui.shared.gui_items.dossier.achievements import validators

class Achieved(RegularAchievement):
    __slots__ = ()

    @classmethod
    def checkIsValid(cls, block, name, dossier):
        return validators.alreadyAchieved(cls, name, block, dossier)


class HonoredRankAchievement(RegularAchievement):
    __slots__ = ()

    def __init__(self, dossier, value=None):
        super(HonoredRankAchievement, self).__init__('honoredRank', _AB.CLIENT, dossier, value)

    def getIcons(self):
        iconName = self._getIconName()
        return {self.ICON_TYPE.IT_180X180: '%s/%s.png' % (self.ICON_PATH_180X180, iconName), 
           self.ICON_TYPE.IT_67X71: '%s/%s.png' % (self.ICON_PATH_67X71, iconName)}

    @classmethod
    def checkIsInDossier(cls, block, name, dossier):
        if dossier is not None:
            return bool(cls.__getCount(dossier))
        else:
            return False

    @classmethod
    def checkIsValid(cls, block, name, dossier):
        return True

    def _readValue(self, dossier):
        return self.__getCount(dossier)

    @classmethod
    def __getCount(cls, dossier):
        return dossier.getRankedStats().getTotalRanksCount()


class MoonSphereAchievement(RegularAchievement, NoProgressBar):
    __slots__ = ()

    def __init__(self, dossier, value=None):
        super(MoonSphereAchievement, self).__init__('moonSphere', _AB.SINGLE, dossier, value)

    @classmethod
    def checkIsValid(cls, block, name, dossier):
        return validators.alreadyAchieved(cls, name, block, dossier)


class ReferralProgramSingleAchievement(RegularAchievement):
    __slots__ = ()

    @classmethod
    def checkIsValid(cls, block, name, dossier):
        return validators.requiresReferralProgram() or validators.alreadyAchieved(cls, name, block, dossier)


class WhiteTigerAchievement(RegularAchievement):
    __slots__ = ()
    WHITE_TIGER_COMP_DESCR = 56337

    def __init__(self, dossier, value=None):
        super(WhiteTigerAchievement, self).__init__('whiteTiger', _AB.CLIENT, dossier, value)

    @classmethod
    def checkIsInDossier(cls, block, name, dossier):
        if dossier is not None:
            return bool(cls.__getWhiteTigerKillings(dossier))
        else:
            return False

    @classmethod
    def checkIsValid(cls, block, name, dossier):
        return validators.alreadyAchieved(cls, name, block, dossier) and not validators.accountIsRoaming(dossier)

    def _readValue(self, dossier):
        return self.__getWhiteTigerKillings(dossier)

    @classmethod
    def __getWhiteTigerKillings(cls, dossier):
        return dossier.getBlock('vehTypeFrags').get(cls.WHITE_TIGER_COMP_DESCR, 0)