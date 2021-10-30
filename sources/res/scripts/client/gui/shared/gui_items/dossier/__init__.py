import math, cPickle, BigWorld, dossiers2
from constants import DOSSIER_TYPE
from gui.Scaleform.locale.MENU import MENU
from gui.impl import backport
from gui.shared.gui_items.Tankman import Tankman
from helpers import dependency, time_utils
from items import tankmen
from helpers import i18n
from gui.shared.gui_items.gui_item import GUIItem
from gui.shared.gui_items.dossier import stats
from gui.shared.gui_items.dossier.factories import getAchievementFactory
from account_helpers.renewable_subscription import RenewableSubscription
from renewable_subscription_common.passive_xp import CrewValidator
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache

def loadDossier(dumpData):
    args = cPickle.loads(dumpData)
    return args[0].unpack(*args[1:])


def dumpDossier(dossierItem):
    return cPickle.dumps(dossierItem.pack())


_SECONDS_IN_MINUTE = 60

class _Dossier(GUIItem):
    __slots__ = ('_dossier', '_dossierType', '_playerDBID')
    lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self, dossier, dossierType, playerDBID=None):
        super(GUIItem, self).__init__()
        self._dossier = dossier
        self._dossierType = dossierType
        self._playerDBID = playerDBID

    def getBlock(self, blockName):
        return self._dossier[blockName]

    def getRecordValue(self, blockName, keyName):
        return self._dossier[blockName][keyName]

    def getDossierDescr(self):
        return self._dossier

    def getDossierType(self):
        return self._dossierType

    def getPlayerDBID(self):
        return self._playerDBID

    def isInRoaming(self):
        if not self.isCurrentUser():
            serverSettings = self.lobbyContext.getServerSettings()
            if serverSettings is not None:
                roaming = serverSettings.roaming
                return roaming.isInRoaming() or roaming.isPlayerInRoaming(self._playerDBID)
        return False

    def isCurrentUser(self):
        return self._playerDBID is None


class VehicleDossier(_Dossier, stats.VehicleDossierStats):

    def __init__(self, dossier, vehTypeCompDescr, playerDBID=None):
        super(VehicleDossier, self).__init__(dossier, DOSSIER_TYPE.VEHICLE, playerDBID)
        self.__vehTypeCompDescr = vehTypeCompDescr

    def getCompactDescriptor(self):
        return self.__vehTypeCompDescr

    def pack(self):
        return (
         VehicleDossier, self._dossier.makeCompDescr(), self.__vehTypeCompDescr,
         self._playerDBID)

    @staticmethod
    def unpack(dossierCD, vehTypeCD, playerDBID):
        return VehicleDossier(dossiers2.getVehicleDossierDescr(dossierCD), vehTypeCD, playerDBID)

    def _getDossierItem(self):
        return self

    def __repr__(self):
        return 'VehicleDossier<vehTypeCD=%d; playerDBID=%r; roaming=%r>' % (
         self.__vehTypeCompDescr, self._playerDBID, self.isInRoaming())


class AccountDossier(_Dossier, stats.AccountDossierStats):
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self, dossier, playerDBID=None, rated7x7Seasons=None):
        super(AccountDossier, self).__init__(dossier, DOSSIER_TYPE.ACCOUNT, playerDBID)
        self._rated7x7Seasons = rated7x7Seasons or {}

    def getGlobalRating(self):
        return self.itemsCache.items.stats.globalRating

    def pack(self):
        return (
         AccountDossier, self._dossier.makeCompDescr(), self._playerDBID,
         self._rated7x7Seasons)

    @staticmethod
    def unpack(dossierCD, playerDBID, seasons):
        return AccountDossier(dossiers2.getAccountDossierDescr(dossierCD), playerDBID, seasons)

    def getRated7x7SeasonDossier(self, seasonID):
        return self._makeSeasonDossier(self._rated7x7Seasons.get(seasonID) or dossiers2.getRated7x7DossierDescr())

    def getRated7x7Seasons(self):
        result = {}
        for sID, d in self._rated7x7Seasons.iteritems():
            result[sID] = self._makeSeasonDossier(d)

        return result

    def _makeSeasonDossier(self, dossierDescr):
        return ClubMemberDossier(dossierDescr, -1, self._playerDBID)

    def _getDossierItem(self):
        return self

    def __repr__(self):
        return 'AccountDossier<playerDBID=%r; roaming=%r>' % (
         self._playerDBID, self.isInRoaming())


class TankmanDossier(_Dossier, stats.TankmanDossierStats):
    _lobbyContext = dependency.descriptor(ILobbyContext)
    PREMIUM_TANK_DEFAULT_CREW_XP_FACTOR = 1.5

    def __init__(self, tmanDescr, tankmanDossierDescr, extDossier, playerDBID=None, currentVehicleItem=None):
        super(TankmanDossier, self).__init__(tankmanDossierDescr, DOSSIER_TYPE.TANKMAN, playerDBID)
        currentVehicleType = currentVehicleItem.descriptor.type if currentVehicleItem else None
        self.tmanDescr = tmanDescr
        self.__totalStats = extDossier.getTotalStats()
        self.__globalMapStats = extDossier.getGlobalMapStats()
        self.__clanStats = extDossier.getClanStats()
        self.__extDossierDump = dumpDossier(extDossier)
        self.__currentVehicleIsPremium = currentVehicleItem and currentVehicleItem.isPremium
        self.__currentVehicleCrewXpFactor = currentVehicleType.crewXpFactor if currentVehicleType else 1.0
        self._renewableSubInfo = BigWorld.player().renewableSubscription
        return

    def pack(self):
        return (TankmanDossier, self.tmanDescr.makeCompactDescr(),
         self._dossier.makeCompDescr(), self.__extDossierDump)

    @staticmethod
    def unpack(tmanCompDescr, dossierCD, extDossierDump):
        return TankmanDossier(tankmen.TankmanDescr(tmanCompDescr), dossiers2.getTankmanDossierDescr(dossierCD), loadDossier(extDossierDump))

    def getAvgXP(self):
        totalXP = self.__totalStats.getXP() - self.__clanStats.getXP() + self.__globalMapStats.getXP()
        totalBattles = self.__totalStats.getBattlesCount() - self.__clanStats.getBattlesCount() + self.__globalMapStats.getBattlesCount()
        if totalBattles == 0:
            return 0
        return totalXP / totalBattles

    def getBattlesCount(self):
        return self.getTotalStats().getBattlesCount()

    def getStats(self, tankman):
        imageType, image = self.__getCurrentSkillIcon(tankman)
        result = [
         {'label': 'common', 
            'stats': (
                    self.__packStat('battlesCount', self.getBattlesCount()),
                    self.__packStat('avgExperience', self.getAvgXP()))}]
        studyingBlock = {'label': 'studying', 
           'secondLabel': i18n.makeString(MENU.CONTEXTMENU_PERSONALCASE_STATSBLOCKTITLE), 
           'isRowSeparator': True, 
           'isPremium': self.__currentVehicleIsPremium, 
           'stats': [
                   self.__packStat('nextSkillXPLeft', tankman.getNextLevelXpCost(), imageType=imageType, image=image, isSecondActive=self.__currentVehicleIsPremium),
                   self.__packStat('nextSkillBattlesLeft', self.__getNextSkillBattlesLeft(tankman), usePremiumXpFactor=True, isSecondActive=self.__currentVehicleIsPremium)]}
        showPassiveCrewXpInfo = self._renewableSubInfo.isEnabled() and self.lobbyContext.getServerSettings().isRenewableSubPassiveCrewXPEnabled()
        if showPassiveCrewXpInfo:
            statsBlock = studyingBlock.get('stats', [])
            statsBlock.append(self.__packWotPlus(tankman))
        result.append(studyingBlock)
        return result

    def _getDossierItem(self):
        return self

    def __isNewSkillReady(self, tankman):
        return self.tmanDescr.roleLevel == tankmen.MAX_SKILL_LEVEL and (not self.tmanDescr.skills or self.tmanDescr.lastSkillLevel == tankmen.MAX_SKILL_LEVEL) and tankman.hasNewSkill(useCombinedRoles=True)

    def __getCurrentSkillIcon(self, tankman):
        if self.__isNewSkillReady(tankman):
            return ('new_skill', 'new_skill.png')
        if self.tmanDescr.roleLevel != tankmen.MAX_SKILL_LEVEL or not self.tmanDescr.skills:
            return ('role', '%s.png' % self.tmanDescr.role)
        return ('skill', tankmen.getSkillsConfig().getSkill(self.tmanDescr.skills[(-1)]).icon)

    def __getNextSkillBattlesLeft(self, tankman):
        if not self.getBattlesCount():
            result = None
        else:
            avgExp = self.getAvgXP()
            newSkillReady = self.tmanDescr.roleLevel == tankmen.MAX_SKILL_LEVEL and (not self.tmanDescr.skills or self.tmanDescr.lastSkillLevel == tankmen.MAX_SKILL_LEVEL)
            if avgExp and not newSkillReady:
                result = max(1, math.ceil(tankman.getNextLevelXpCost() / avgExp))
            else:
                result = 0
        return result

    def __formatValueForUI(self, value):
        if value is None:
            return i18n.makeString('#menu:profile/stats/items/empty')
        else:
            return backport.getIntegralFormat(value)

    def __getBattlesLeftOnPremiumVehicle(self, value):
        xpFactorToUse = self.PREMIUM_TANK_DEFAULT_CREW_XP_FACTOR
        if self.__currentVehicleIsPremium:
            xpFactorToUse = self.__currentVehicleCrewXpFactor
        if value is not None:
            if value != 0:
                return max(1, value / xpFactorToUse)
            return 0
        return

    def __packWotPlus(self, tankman):
        tankManIsEligible = False
        tankHasPassiveXp = False
        if tankman.vehicleDescr:
            validator = CrewValidator(tankman.vehicleDescr.type)
            result = validator.validateCrewSlot(tankman.strCD)
            tankManIsEligible = not result.isEmpty and result.tManValidRes.isValid
            tankHasPassiveXp = self._renewableSubInfo.vehicleCrewHasIdleXP(tankman.vehicleInvID)
        xpPerMinute = self._lobbyContext.getServerSettings().getRenewableSubCrewXPPerMinute()
        xpPerSecond = float(xpPerMinute) / _SECONDS_IN_MINUTE
        secUntilNextLevel = tankman.getNextLevelXpCost() / xpPerSecond
        timeStr = time_utils.getTillTimeString(secUntilNextLevel, MENU.TIME_TIMEVALUE, removeLeadingZeros=True) if tankManIsEligible and secUntilNextLevel else '--'
        return {'name': 'timeUntilNextLevel', 
           'value': timeStr, 
           'secondValue': timeStr, 
           'isLabelActive': tankHasPassiveXp and tankManIsEligible, 
           'isValueActive': tankHasPassiveXp and tankManIsEligible and not self.__currentVehicleIsPremium, 
           'isSecondValueActive': tankHasPassiveXp and tankManIsEligible and self.__currentVehicleIsPremium}

    def __packStat(self, name, value, imageType=None, image=None, usePremiumXpFactor=False, isSecondActive=False):
        if usePremiumXpFactor:
            secondValue = self.__getBattlesLeftOnPremiumVehicle(value)
        else:
            secondValue = value
        value = self.__formatValueForUI(value)
        secondValue = self.__formatValueForUI(secondValue)
        return {'name': name, 
           'value': value, 
           'secondValue': secondValue, 
           'isValueActive': not isSecondActive, 
           'isSecondValueActive': isSecondActive, 
           'imageType': imageType, 
           'image': image}

    def __repr__(self):
        return 'TankmanDossier<stats.__totalStats=%r>' % self.__totalStats


class FortDossier(_Dossier, stats.FortDossierStats):

    def __init__(self, dossier, playerDBID=False):
        super(FortDossier, self).__init__(dossier, DOSSIER_TYPE.FORTIFIED_REGIONS, playerDBID)

    def pack(self):
        return (
         FortDossier, self._dossier.makeCompDescr(), self._playerDBID)

    @staticmethod
    def unpack(dossierCD, playerDBID):
        return FortDossier(dossiers2.getFortifiedRegionsDossierDescr(dossierCD), playerDBID)

    def _getDossierItem(self):
        return self

    def __repr__(self):
        return 'FortDossier<playerDBID=%r; roaming=%r>' % (
         self._playerDBID, self.isInRoaming())


class ClubDossier(_Dossier, stats.ClubDossierStats):

    def __init__(self, dossier, clubDbID):
        super(ClubDossier, self).__init__(dossier, DOSSIER_TYPE.CLUB)
        self._clubDbID = clubDbID

    def pack(self):
        return (
         ClubDossier, self._dossier.makeCompDescr(), self._clubDbID)

    @staticmethod
    def unpack(dossierCD, clubDbID):
        return ClubDossier(dossiers2.getClubDossierDescr(dossierCD), clubDbID)

    def getClubDbID(self):
        return self._clubDbID

    def _getDossierItem(self):
        return self


class ClubMemberDossier(_Dossier, stats.ClubMemberDossierStats):

    def __init__(self, dossier, clubDbID, memberDbID):
        super(ClubMemberDossier, self).__init__(dossier, DOSSIER_TYPE.RATED7X7, memberDbID)
        self._clubDbID = clubDbID

    def pack(self):
        return (
         ClubMemberDossier, self._dossier.makeCompactDescr(), self._clubDbID,
         self._playerDBID)

    @staticmethod
    def unpack(dossierCD, clubDbID, memberDbID):
        return ClubMemberDossier(dossiers2.getRated7x7DossierDescr(dossierCD), clubDbID, memberDbID)

    def getClubDbID(self):
        return self._clubDbID

    def _getDossierItem(self):
        return self