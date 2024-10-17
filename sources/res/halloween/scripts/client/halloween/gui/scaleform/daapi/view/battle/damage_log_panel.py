from gui.impl import backport
from gui.impl.gen import R
from gui.Scaleform.daapi.view.battle.shared.damage_log_panel import DamageLogPanel, _LogViewComponent, _DamageActionImgVOBuilder, _LogRecordVOBuilder, _VehicleVOBuilder, _EMPTY_SHELL_VO_BUILDER, _DAMAGE_VALUE_VO_BUILDER, _ReceivedHitVehicleVOBuilder, _DamageShellVOBuilder, _ShellVOBuilder, _CritsShellVOBuilder, _CriticalHitValueVOBuilder, _ActionImgVOBuilder, _AssistActionImgVOBuilder
from gui.battle_control.battle_constants import PERSONAL_EFFICIENCY_TYPE as _ETYPE
from gui.Scaleform.genConsts.BATTLEDAMAGELOG_IMAGES import BATTLEDAMAGELOG_IMAGES as _IMAGES
from halloween.gui.scaleform.genConsts.HW_BATTLEDAMAGELOG_IMAGES import HW_BATTLEDAMAGELOG_IMAGES as _HW_IMAGES
from halloween_common.halloween_constants import ATTACK_REASON
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from halloween.gui.hw_vehicle_role_helper import getVehicleRole
_HW_VEHICLE_CLASS_TAGS_ICONS = {'boss': _HW_IMAGES.DAMAGELOG_BOSS_16X16, 
   'sentry': _HW_IMAGES.DAMAGELOG_SENTRY_16X16, 
   'hunter': _HW_IMAGES.DAMAGELOG_HUNTER_16X16, 
   'runner': _HW_IMAGES.DAMAGELOG_RUNNER_16X16, 
   'alpha': _HW_IMAGES.DAMAGELOG_ALPHA_16X16, 
   'turret': _HW_IMAGES.DAMAGELOG_TURRET_16X16, 
   'bomber': _HW_IMAGES.DAMAGELOG_BOMBER_16X16, 
   'bomber_alpha': _HW_IMAGES.DAMAGELOG_BOMBER_ALPHA_16X16, 
   'catcher': _HW_IMAGES.DAMAGELOG_CATCHER_16X16, 
   'charger': _HW_IMAGES.DAMAGELOG_CHARGER_16X16}

class HWReceivedHitVehicleVOBuilder(_ReceivedHitVehicleVOBuilder):

    def _populateVO(self, vehicleVO, info, arenaDP):
        super(HWReceivedHitVehicleVOBuilder, self)._populateVO(vehicleVO, info, arenaDP)
        if info.isStaticDeathZone():
            vehicleVO.vehicleName = backport.text(R.strings.ingame_gui.damageLog.static_death_zone())
            vehicleVO.vehicleTypeImg = _IMAGES.DAMAGELOG_STATIC_DEATH_ZONE_16X16
            return
        else:
            if info.isDeathZone():
                vehicleVO.vehicleName = backport.text(R.strings.ingame_gui.damageLog.personal_death_zone())
                vehicleVO.vehicleTypeImg = _IMAGES.DAMAGELOG_STATIC_DEATH_ZONE_16X16
                return
            vInfo = arenaDP.getVehicleInfo(info.getArenaVehicleID())
            vehicleType = vInfo.vehicleType
            role = getVehicleRole(vehicleType)
            if role is not None:
                vehicleVO.vehicleTypeImg = _HW_VEHICLE_CLASS_TAGS_ICONS[role]
            if vInfo.isEnemy():
                vehicleVO.vehicleName = vehicleType.name
            return


class HWExtendedDamageActionVOBuilder(_DamageActionImgVOBuilder):
    DEFAULT_DAMAGE_ICON = _IMAGES.DAMAGELOG_DAMAGE_16X16
    HW_ATTACK_REASON_TO_ICON = {ATTACK_REASON.HALLOWEEN_ABILITY_VAMPIRE: _IMAGES.DAMAGELOG_DAMAGE_16X16, 
       ATTACK_REASON.HALLOWEEN_ABILITY_AOE_DAMAGE: _IMAGES.DAMAGELOG_DAMAGE_16X16}

    def _getImage(self, info):
        img = self._getIcon(info.getAttackReasonID())
        return img or super(HWExtendedDamageActionVOBuilder, self)._getImage(info)

    @classmethod
    def _getIcon(cls, reasonID):
        attackReason = ATTACK_REASON.getValue(reasonID)
        res = cls.HW_ATTACK_REASON_TO_ICON.get(attackReason)
        if not res and attackReason in ATTACK_REASON.getExtraAttrs().itervalues():
            res = cls.DEFAULT_DAMAGE_ICON
        return res


class HWExtendedReceivedDamageActionVOBuilder(HWExtendedDamageActionVOBuilder):
    DEFAULT_DAMAGE_ICON = _IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16
    HW_ATTACK_REASON_TO_ICON = {ATTACK_REASON.HALLOWEEN_BOMBER_EXPLOSION: _IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16, 
       ATTACK_REASON.HALLOWEEN_BOSS_AURA: _IMAGES.DAMAGELOG_BURN_ENEMY_16X16, 
       ATTACK_REASON.HALLOWEEN_ABILITY_VAMPIRE: _IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16, 
       ATTACK_REASON.HALLOWEEN_ABILITY_AOE_DAMAGE: _IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16}


class HWVehicleVOBuilder(_VehicleVOBuilder):

    def _populateVO(self, vehicleVO, info, arenaDP):
        super(HWVehicleVOBuilder, self)._populateVO(vehicleVO, info, arenaDP)
        vInfo = arenaDP.getVehicleInfo(info.getArenaVehicleID())
        vehicleType = vInfo.vehicleType
        role = getVehicleRole(vehicleType)
        if role is not None:
            vehicleVO.vehicleTypeImg = _HW_VEHICLE_CLASS_TAGS_ICONS[role]
        if vInfo.isEnemy():
            vehicleVO.vehicleName = vehicleType.name
        return


_HW_ETYPE_TO_RECORD_VO_BUILDER = {_ETYPE.DAMAGE: _LogRecordVOBuilder(HWVehicleVOBuilder(), _EMPTY_SHELL_VO_BUILDER, _DAMAGE_VALUE_VO_BUILDER, HWExtendedDamageActionVOBuilder(shotIcon=_IMAGES.DAMAGELOG_DAMAGE_16X16, fireIcon=_IMAGES.DAMAGELOG_FIRE_16X16, ramIcon=_IMAGES.DAMAGELOG_RAM_16X16, wcIcon=_IMAGES.DAMAGELOG_ICON_WORLD_COLLISION, mineFieldIcon=_IMAGES.DAMAGELOG_MINE_FIELD_16X16, spawnBotDmgIcon=_IMAGES.DAMAGELOG_YOUR_SPAWNED_BOT_DMG_16X16, corrodingShotIcon=_IMAGES.DAMAGELOG_CORRODING_SHOT_16X16, fireCircleDmgIcon=_IMAGES.DAMAGELOG_FIRE_CIRCLE_16X16, clingBranderDmgIcon=_IMAGES.DAMAGELOG_CLING_BRANDER_16X16, thunderStrikeIcon=_IMAGES.DAMAGELOG_THUNDER_STRIKE_16X16, airstrikeIcon=_IMAGES.DAMAGELOG_AIRSTRIKE_EQ_16X16, artilleryIcon=_IMAGES.DAMAGELOG_ARTILLERY_EQ_16X16)), 
   _ETYPE.RECEIVED_DAMAGE: _LogRecordVOBuilder(HWReceivedHitVehicleVOBuilder(), _DamageShellVOBuilder(), _DAMAGE_VALUE_VO_BUILDER, HWExtendedReceivedDamageActionVOBuilder(shotIcon=_IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16, fireIcon=_IMAGES.DAMAGELOG_BURN_ENEMY_16X16, ramIcon=_IMAGES.DAMAGELOG_RAM_ENEMY_16X16, wcIcon=_IMAGES.DAMAGELOG_DAMAGE_ENEMY_16X16, mineFieldIcon=_IMAGES.DAMAGELOG_BY_MINE_FIELD_16X16, berserkerIcon=_IMAGES.DAMAGELOG_BERSERKER_16X16, spawnBotDmgIcon=_IMAGES.DAMAGELOG_DMG_BY_SPAWNED_BOT_16X16, smokeDmgIcon=_IMAGES.DAMAGELOG_DMG_BY_SMOKE_16X16, corrodingShotIcon=_IMAGES.DAMAGELOG_CORRODING_SHOT_ENEMY_16X16, fireCircleDmgIcon=_IMAGES.DAMAGELOG_FIRE_CIRCLE_ENEMY_16X16, clingBranderDmgIcon=_IMAGES.DAMAGELOG_CLING_BRANDER_ENEMY_16X16, thunderStrikeIcon=_IMAGES.DAMAGELOG_THUNDER_STRIKE_ENEMY_16X16, airstrikeIcon=_IMAGES.DAMAGELOG_AIRSTRIKE_EQ_ENEMY_16X16, artilleryIcon=_IMAGES.DAMAGELOG_ARTILLERY_EQ_ENEMY_16X16, airstrikeZoneIcon=_IMAGES.DAMAGELOG_AIRSTRIKE_ENEMY_16X16, deathZoneIcon=_IMAGES.DAMAGELOG_ARTILLERY_ENEMY_16X16)), 
   _ETYPE.BLOCKED_DAMAGE: _LogRecordVOBuilder(HWVehicleVOBuilder(), _ShellVOBuilder(), _DAMAGE_VALUE_VO_BUILDER, _ActionImgVOBuilder(image=_IMAGES.DAMAGELOG_REFLECT_16X16)), 
   _ETYPE.ASSIST_DAMAGE: _LogRecordVOBuilder(HWVehicleVOBuilder(), _EMPTY_SHELL_VO_BUILDER, _DAMAGE_VALUE_VO_BUILDER, _AssistActionImgVOBuilder()), 
   _ETYPE.RECEIVED_CRITICAL_HITS: _LogRecordVOBuilder(HWReceivedHitVehicleVOBuilder(), _CritsShellVOBuilder(), _CriticalHitValueVOBuilder(), _ActionImgVOBuilder(image=_IMAGES.DAMAGELOG_CRITICAL_ENEMY_16X16))}

class _HWLogViewComponent(_LogViewComponent):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def updateViewMode(self, viewMode):
        if viewMode != self._logViewMode:
            self._logViewMode = viewMode
            self.invalidate()

    def _buildLogMessageVO(self, info):
        builder = _HW_ETYPE_TO_RECORD_VO_BUILDER.get(info.getType(), None)
        if builder is not None:
            return builder.buildVO(info, self.sessionProvider.getArenaDP())
        else:
            return super(_HWLogViewComponent, self)._buildLogMessageVO(info)


class HWDamageLogPanel(DamageLogPanel):

    def __init__(self):
        super(HWDamageLogPanel, self).__init__()
        self._topLog = _HWLogViewComponent()
        self._bottomLog = _HWLogViewComponent()
        self.__vehStateCtrl = self.sessionProvider.shared.vehicleState

    def _onVehicleControlling(self, vehicle):
        if not self.__vehStateCtrl.isInPostmortem:
            self._invalidatePanelVisibility()
        self._invalidateTotalDamages()