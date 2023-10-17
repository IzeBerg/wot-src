from constants import DEATH_REASON_ALIVE
from gui.battle_results.reusable import sort_keys
from gui.battle_results.components import base, common
from gui.battle_results.settings import PLAYER_TEAM_RESULT
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.utils import toUpper
from halloween_common.halloween_constants import INVALID_BATTLE_PLACE

class HwPhaseItem(base.StatsItem):

    def _convert(self, result, reusable):
        return reusable.getPersonalVehiclesInfo(result).hwPhase


class HwPhasesCountItem(base.StatsItem):

    def _convert(self, result, reusable):
        return reusable.getPersonalVehiclesInfo(result).hwPhasesCount


class HwEffectivenessArtefactKeysItem(base.StatsItem):
    __slots__ = ()

    def _convert(self, result, reusable):
        return reusable.getPersonalVehiclesInfo(result).effectivenessKeys


class HwBossArtefactKeysItem(base.StatsItem):
    __slots__ = ()

    def _convert(self, result, reusable):
        return reusable.getPersonalVehiclesInfo(result).bossKeys


class PersonalFirstTeamItemSortKey(sort_keys.TeamItemSortKey):
    __slots__ = ('_sortKey', )

    def __init__(self, vehicleInfo, compareKey):
        super(PersonalFirstTeamItemSortKey, self).__init__(vehicleInfo)
        self._sortKey = compareKey

    def _cmp(self, other):
        sortKey = self._sortKey
        return cmp(getattr(other.info, sortKey), getattr(self.info, sortKey))


class HWAfkSortKey(sort_keys.TeamItemSortKey):
    __slots__ = ()

    def _cmp(self, other):
        return cmp(self._isAfk(self.info), self._isAfk(other.info))

    @staticmethod
    def _isAfk(info):
        return getattr(info, 'hwTeamFightPlace') == INVALID_BATTLE_PLACE


class HWVehicleStatsBlock(base.StatsBlock):
    __slots__ = ('playerDBID', 'playerName', 'vehicleName', 'vehicleType', 'vehicleCD',
                 'vehicleLvl', 'clanAbbrev', 'artefactKeys', 'isPlayer', 'squadID',
                 'isOwnSquad', 'killerName', 'deathReason', 'kills', 'damageDealt',
                 'soulsDelivered', 'badgeID', 'badgeSuffixID', 'isAfk')

    def __init__(self, meta=None, field='', *path):
        super(HWVehicleStatsBlock, self).__init__(meta, field, *path)
        self.playerDBID = 0
        self.playerName = ''
        self.vehicleName = ''
        self.vehicleType = ''
        self.vehicleCD = 0
        self.vehicleLvl = -1
        self.clanAbbrev = ''
        self.artefactKeys = 0
        self.killerName = ''
        self.deathReason = -1
        self.kills = 0
        self.damageDealt = 0
        self.soulsDelivered = 0
        self.isPlayer = False
        self.squadID = -1
        self.isOwnSquad = False
        self.badgeID = 0
        self.badgeSuffixID = 0
        self.isAfk = False

    def setRecord(self, result, reusable):
        super(HWVehicleStatsBlock, self).setRecord(result, reusable)
        self.playerDBID = result.player.dbID
        self.playerName = result.player.realName
        self.vehicleName = result.vehicle.userName
        self.vehicleType = result.vehicle.type
        self.vehicleCD = result.vehicle.intCD
        self.vehicleLvl = result.vehicle.level
        self.clanAbbrev = result.player.clanAbbrev
        self.artefactKeys = result.totalKeys
        self.deathReason = result.deathReason
        self.kills = result.kills
        self.damageDealt = result.damageDealt
        self.soulsDelivered = result.soulsDelivered
        self.isPlayer = self.playerDBID == reusable.personal.avatar.accountDBID
        self.squadID = result.player.squadIndex
        self.isAfk = result.hwTeamFightPlace == INVALID_BATTLE_PLACE
        personalInfo = reusable.getPlayerInfo()
        personalPrebattleID = personalInfo.prebattleID if personalInfo.squadIndex else 0
        self.isOwnSquad = personalPrebattleID != 0 and personalPrebattleID == result.player.prebattleID
        avatar = reusable.avatars.getAvatarInfo(result.player.dbID)
        self.badgeID = avatar.badge if avatar else 0
        self.badgeSuffixID = avatar.suffixBadge
        if self.deathReason > DEATH_REASON_ALIVE:
            if result.killerID:
                killerVehicle = reusable.getPlayerInfoByVehicleID(result.killerID)
                self.killerName = killerVehicle.fakeName


class HWBattlesTeamStatsBlock(base.StatsBlock):
    __slots__ = ()

    def setRecord(self, result, reusable):
        allies, _ = reusable.getBiDirectionTeamsIterator(result, sortKey=lambda info: (
         HWAfkSortKey(info),
         PersonalFirstTeamItemSortKey(info, 'totalKeys'),
         PersonalFirstTeamItemSortKey(info, 'hwTeamContribution'),
         PersonalFirstTeamItemSortKey(info, 'kills')))
        for item in allies:
            block = HWVehicleStatsBlock()
            block.setRecord(item, reusable)
            self.addComponent(self.getNextComponentIndex(), block)


class HWBattleFinishResultBlock(common.RegularFinishResultBlock):
    _FULL_RESULT_LABEL_PREFIX = R.strings.battle_results.hw_battle_result.status
    _REASON_DESCR_LABEL_PREFIX = R.strings.battle_results.hw_finish.reason

    def setRecord(self, result, reusable):
        teamRes = reusable.getPersonalTeamResult()
        vInfo = reusable.getPersonalVehiclesInfo(result['personal'])
        reasonDescr = self._REASON_DESCR_LABEL_PREFIX.dyn(teamRes).descr
        hwPhases = max(0, vInfo.hwPhase - 1)
        args = {} if teamRes == PLAYER_TEAM_RESULT.WIN else {'current': hwPhases, 'total': vInfo.hwPhasesCount}
        self.shortResultLabel = teamRes
        self.fullResultLabel = toUpper(backport.text(self._FULL_RESULT_LABEL_PREFIX.dyn(teamRes)()))
        self.finishReasonLabel = backport.text(reasonDescr(), **args)
        self.finishReasonClarificationLabel = ''