import BigWorld, BattleReplay
from halloween_common.hw_battle_feedback import HWGameplayActionID
from halloween_common.hw_battle_feedback import unpackGameplayActionFeedback
from gui.Scaleform.daapi.view.battle.shared.ribbons_aggregator import RibbonsAggregator, _RibbonClassFactory, _ACCUMULATED_RIBBON_TYPES, _FEEDBACK_EVENTS_TO_IGNORE as _DEFAULT_EVENTS_TO_IGNORE, _FEEDBACK_EVENT_TO_RIBBON_CLS_FACTORY as _DEFAULT_RIBBON_FACTORIES, _CausedDamageRibbon, _RIBBON_TYPES_AGGREGATED_WITH_KILL_RIBBON as _DEFAULT_RIBBONS_AGGREGATED_WITH_KILL, DAMAGE_SOURCE, _Ribbon, _SingleVehicleReceivedHitRibbon, _AssistRibbonClassFactory, _RadioAssistRibbon, _TrackAssistRibbon, _StunAssistRibbon
from gui.Scaleform.daapi.view.battle.shared.ribbons_panel import _singleVehRibbonFormatter, _getVehicleData, _formatCounter
from halloween.gui.halloween_gui_constants import FEEDBACK_EVENT_ID
from halloween_common.halloween_constants import ATTACK_REASON, BATTLE_EVENT_TYPE
from halloween.gui.scaleform.genConsts.HW_BATTLE_EFFICIENCY_TYPES import HW_BATTLE_EFFICIENCY_TYPES
from gui.Scaleform.genConsts.BATTLE_EFFICIENCY_TYPES import BATTLE_EFFICIENCY_TYPES
from gui.battle_control.controllers.feedback_events import _BATTLE_EVENT_TO_PLAYER_FEEDBACK_EVENT, _PLAYER_FEEDBACK_EXTRA_DATA_CONVERTERS
from gui.impl import backport
from gui.impl.gen import R
_BATTLE_EVENT_TO_PLAYER_FEEDBACK_EVENT.update({BATTLE_EVENT_TYPE.HW_GAMEPLAY_ACTION: FEEDBACK_EVENT_ID.HW_GAMEPLAY_ACTION})
_PLAYER_FEEDBACK_EXTRA_DATA_CONVERTERS.update({FEEDBACK_EVENT_ID.HW_GAMEPLAY_ACTION: unpackGameplayActionFeedback})
_HW_FEEDBACK_EVENT_TO_RIBBON_CLS_FACTORY = {}
_HW_FEEDBACK_EVENT_TO_RIBBON_CLS_FACTORY.update(_DEFAULT_RIBBON_FACTORIES)
_HW_FEEDBACK_EVENT_TO_RIBBON_CLS_FACTORY.pop(FEEDBACK_EVENT_ID.VEHICLE_HEALTH_ADDED, None)
_HW_FEEDBACK_EVENTS_TO_IGNORE = _DEFAULT_EVENTS_TO_IGNORE + (FEEDBACK_EVENT_ID.VEHICLE_HEALTH_ADDED,)
_HW_RIBBON_TYPES_AGGREGATED_WITH_KILL_RIBBON = []
_HW_RIBBON_TYPES_AGGREGATED_WITH_KILL_RIBBON.extend(_DEFAULT_RIBBONS_AGGREGATED_WITH_KILL)
_HW_RIBBON_TYPES_COPY_TO = {}

def _formatAddition(value):
    return backport.text(R.strings.halloween_battle.efficiencyRibbons.additionFormat(), value=value)


def _hwActionRibbonFormatter(ribbon, arenaDP, updater):
    if ribbon.isShowActionSource:
        vehicleName, vehicleClassTag = _getVehicleData(arenaDP, ribbon.vehicleID)
    else:
        vehicleName, vehicleClassTag = ('', '')
    updater(ribbonID=ribbon.getID(), ribbonType=ribbon.getType(), leftFieldStr=ribbon.actionValue, vehName=vehicleName, vehType=vehicleClassTag)


def _hwModulesInvulnerabilityRibbonFormatter(ribbon, arenaDP, updater):
    if ribbon.isShowActionSource:
        vehicleName, vehicleClassTag = _getVehicleData(arenaDP, ribbon.vehicleID)
    else:
        vehicleName, vehicleClassTag = ('', '')
    updater(ribbonID=ribbon.getID(), ribbonType=ribbon.getType(), leftFieldStr=_formatCounter(ribbon.actionValue), vehName=vehicleName, vehType=vehicleClassTag)


def _hwShellsPickupRibbonFormatter(ribbon, arenaDP, updater):
    if ribbon.isShowActionSource:
        vehicleName, vehicleClassTag = _getVehicleData(arenaDP, ribbon.vehicleID)
    else:
        vehicleName, vehicleClassTag = ('', '')
    updater(ribbonID=ribbon.getID(), ribbonType=ribbon.getType(), leftFieldStr=_formatAddition(ribbon.actionValue), vehName=vehicleName, vehType=vehicleClassTag)


class _HWGameplayActionRibbon(_Ribbon):
    __slots__ = ('_actionValue', '_actionID', '_vehicleID', '_effType', '_isPlayerVehicle')
    BATTLE_EFFICIENCY_TYPE = None

    def __init__(self, ribbonID, actionCtx):
        super(_HWGameplayActionRibbon, self).__init__(ribbonID)
        self._vehicleID = actionCtx.targetID
        self._actionValue = actionCtx.value
        self._actionID = actionCtx.id
        self._effType = self.BATTLE_EFFICIENCY_TYPE
        self._isPlayerVehicle = self._vehicleID == BigWorld.player().playerVehicleID

    @classmethod
    def createFromFeedbackEvent(cls, ribbonID, event):
        return cls(ribbonID, event.getExtra())

    @property
    def actionValue(self):
        return self._actionValue

    @property
    def actionID(self):
        return self._actionID

    @property
    def vehicleID(self):
        return self._vehicleID

    @property
    def isShowActionSource(self):
        return not self._isPlayerVehicle

    def getFormatter(self):
        return _hwActionRibbonFormatter

    def getType(self):
        return self._effType

    def _canAggregate(self, ribbon):
        return isinstance(ribbon, self.__class__) and ribbon.actionID == self.actionID and self._vehicleID == ribbon._vehicleID

    def _aggregate(self, ribbon):
        self._actionValue += ribbon.actionValue


def registerRibbonsFactory(eventID):

    def decorator(cls):
        _HW_FEEDBACK_EVENT_TO_RIBBON_CLS_FACTORY[eventID] = cls()
        return cls

    return decorator


def aggregateWithKillRibbon(cls):
    effType = cls.BATTLE_EFFICIENCY_TYPE
    if effType not in _HW_RIBBON_TYPES_AGGREGATED_WITH_KILL_RIBBON:
        _HW_RIBBON_TYPES_AGGREGATED_WITH_KILL_RIBBON.append(effType)
    return cls


def hwCopyTo(ribbonType, isMergeCopy=False):

    def decorator(cls):
        setattr(cls, 'hwIsMergeCopy', isMergeCopy)
        _HW_RIBBON_TYPES_COPY_TO.setdefault(ribbonType, set()).add(cls)

    return decorator


class _HWCausedDamageRibbon(_CausedDamageRibbon):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = None

    def getType(self):
        return self.BATTLE_EFFICIENCY_TYPE

    def getFormatter(self):
        return _singleVehRibbonFormatter


class _HWCausedAoeAbilityDamage(_HWCausedDamageRibbon):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = None

    def getDamageSource(self):
        return DAMAGE_SOURCE.HIDE

    def _canAggregate(self, ribbon):
        return isinstance(ribbon, self.__class__)


class _HWAbstractDamageRibbonsFactory(_RibbonClassFactory):
    ATTACK_REASONS = None

    def getRibbonClass(self, event):
        result = self._getHWRibbonClass(event.getExtra().getAttackReasonID(), event.getExtra().getSecondaryAttackReasonID())
        return result or self._DEFAULT_FACTORY.getRibbonClass(event)

    @classmethod
    def registerAttackReasonRibbon(cls, reason, secondaryReason=None):

        def decorator(ribbonCls):
            key = (ATTACK_REASON.getIndex(reason), ATTACK_REASON.getIndex(secondaryReason)) if secondaryReason else ATTACK_REASON.getIndex(reason)
            cls.ATTACK_REASONS[key] = ribbonCls
            return ribbonCls

        return decorator

    @classmethod
    def _getHWRibbonClass(cls, reasonID, secondaryReasonID):
        registry = cls.ATTACK_REASONS
        return registry.get((reasonID, secondaryReasonID), None) or registry.get(reasonID, None)


@registerRibbonsFactory(FEEDBACK_EVENT_ID.PLAYER_DAMAGED_HP_ENEMY)
class HWDamageRibbonsFactory(_HWAbstractDamageRibbonsFactory):
    ATTACK_REASONS = {}
    _DEFAULT_FACTORY = _DEFAULT_RIBBON_FACTORIES[FEEDBACK_EVENT_ID.PLAYER_DAMAGED_HP_ENEMY]


@registerRibbonsFactory(FEEDBACK_EVENT_ID.ENEMY_DAMAGED_HP_PLAYER)
class HWReceiveDamageRibbonsFactory(_HWAbstractDamageRibbonsFactory):
    ATTACK_REASONS = {}
    _DEFAULT_FACTORY = _DEFAULT_RIBBON_FACTORIES[FEEDBACK_EVENT_ID.ENEMY_DAMAGED_HP_PLAYER]


@registerRibbonsFactory(FEEDBACK_EVENT_ID.HW_GAMEPLAY_ACTION)
class HWGameplayActionRibbonsFactory(_RibbonClassFactory):
    GAMEPLAY_ACTIONS = {}

    def getRibbonClass(self, event):
        actionID = event.getExtra().id
        return self._getHWRibbonClass(actionID)

    @classmethod
    def registerActionRibbon(cls, reason):

        def decorator(ribbonCls):
            cls.GAMEPLAY_ACTIONS[reason] = ribbonCls
            return ribbonCls

        return decorator

    @classmethod
    def _getHWRibbonClass(cls, key):
        return cls.GAMEPLAY_ACTIONS.get(key, None)


@hwCopyTo(BATTLE_EFFICIENCY_TYPES.DESTRUCTION, isMergeCopy=True)
@HWDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_ABILITY_VAMPIRE)
class _HWCausedVampiricDamageRibbon(_HWCausedAoeAbilityDamage):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_DMG_VAMPIRE


@hwCopyTo(BATTLE_EFFICIENCY_TYPES.DESTRUCTION, isMergeCopy=True)
@HWDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_ABILITY_AOE_DAMAGE)
class _HWCausedAoeDamageRibbon(_HWCausedAoeAbilityDamage):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_DAMAGE


@hwCopyTo(BATTLE_EFFICIENCY_TYPES.DESTRUCTION, isMergeCopy=True)
@HWDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_SHOT_AOE_DAMAGE)
class _HWCausedAoeDamageInstantShotRibbon(_HWCausedAoeAbilityDamage):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_SHOT_AOE_DAMAGE


@hwCopyTo(BATTLE_EFFICIENCY_TYPES.DESTRUCTION, isMergeCopy=True)
@HWDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_SHOT_AOE_DRAIN_ENEMY_HP)
class _HWCausedAoeDrainEnemyHpInstantShotDamageRibbon(_HWCausedAoeAbilityDamage):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_SHOT_AOE_DRAIN_ENEMY_HP


@hwCopyTo(BATTLE_EFFICIENCY_TYPES.DESTRUCTION, isMergeCopy=True)
@HWDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_SHOT_AOE_STUN)
class _HWCausedAoeStunInstantShotRibbon(_HWCausedAoeAbilityDamage):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_SHOT_AOE_STUN


@hwCopyTo(BATTLE_EFFICIENCY_TYPES.DESTRUCTION, isMergeCopy=True)
@HWDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.FIRE, ATTACK_REASON.HALLOWEEN_ABILITY_IGNITE)
class _HWAoeFireDamageRibbon(_HWCausedAoeAbilityDamage):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_BURN


@aggregateWithKillRibbon
@HWDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.FIRE, ATTACK_REASON.HALLOWEEN_PASSIVE_IGNITE)
class _HWPassiveFireDamageRibbon(_HWCausedDamageRibbon):
    __slots__ = ()
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_PASSIVE_IGNITE


@HWReceiveDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_BOSS_AURA)
class _ReceivedBossAuraHitRibbon(_SingleVehicleReceivedHitRibbon):
    __slots__ = ()
    TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_BOSS_BURN

    def getType(self):
        return self.TYPE

    def getFormatter(self):
        return _singleVehRibbonFormatter


@HWReceiveDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_BOMBER_EXPLOSION)
class _HWReceivedBomberExplosionHitRibbon(_SingleVehicleReceivedHitRibbon):
    __slots__ = ()
    TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_BOMBER_EXPLOSION

    def getType(self):
        return self.TYPE

    def getFormatter(self):
        return _singleVehRibbonFormatter


@HWReceiveDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_ABILITY_VAMPIRE)
class _ReceivedVampireAbilityRibbon(_SingleVehicleReceivedHitRibbon):
    __slots__ = ()
    TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_DMG_VAMPIRE_RECEIVED

    def getType(self):
        return self.TYPE

    def getFormatter(self):
        return _singleVehRibbonFormatter


@HWReceiveDamageRibbonsFactory.registerAttackReasonRibbon(ATTACK_REASON.HALLOWEEN_ABILITY_AOE_DAMAGE)
class _ReceivedAOEDamageAbilityHitRibbon(_SingleVehicleReceivedHitRibbon):
    __slots__ = ()
    TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_AOE_DAMAGE_RECEIVED

    def getType(self):
        return self.TYPE

    def getFormatter(self):
        return _singleVehRibbonFormatter


@HWGameplayActionRibbonsFactory.registerActionRibbon(HWGameplayActionID.VEHICLE_REPAIR_INCOMING)
class _HWIncomingRepairRibbon(_HWGameplayActionRibbon):
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR

    @property
    def healerID(self):
        return self.vehicleID

    @property
    def isSelfHeal(self):
        return self._isPlayerVehicle

    def getType(self):
        if self.isSelfHeal:
            return HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR
        return HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR_BY_OTHER

    def _canAggregate(self, ribbon):
        return super(_HWIncomingRepairRibbon, self)._canAggregate(ribbon) and self.healerID == ribbon.healerID


@HWGameplayActionRibbonsFactory.registerActionRibbon(HWGameplayActionID.VEHICLE_REPAIR_OUTCOMING)
class _HWOutcomingRepairRibbon(_HWGameplayActionRibbon):
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_REPAIR_OTHER

    @property
    def isShowActionSource(self):
        return False

    def _canAggregate(self, ribbon):
        return isinstance(ribbon, self.__class__) and ribbon.actionID == self.actionID


@HWGameplayActionRibbonsFactory.registerActionRibbon(HWGameplayActionID.MODULES_DAMAGE_BLOCKED)
class _HWModulesDamageBlockedRibbon(_HWGameplayActionRibbon):
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_MODULES_DAMAGE_BLOCKED

    @property
    def isShowActionSource(self):
        return False

    def getFormatter(self):
        return _hwModulesInvulnerabilityRibbonFormatter

    def _canAggregate(self, ribbon):
        return isinstance(ribbon, self.__class__) and ribbon.actionID == self.actionID

    def _aggregate(self, ribbon):
        self._actionValue += ribbon.actionValue


@HWGameplayActionRibbonsFactory.registerActionRibbon(HWGameplayActionID.HEALTH_DRAINED_BY_PASSIVE_VAMPIRE)
class _HWHealthDrainedByPassiveVampireRibbon(_HWGameplayActionRibbon):
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_PASSIVE_VAMPIRE

    @property
    def isShowActionSource(self):
        return False

    def _canAggregate(self, ribbon):
        return isinstance(ribbon, self.__class__) and ribbon.actionID == self.actionID


@HWGameplayActionRibbonsFactory.registerActionRibbon(HWGameplayActionID.SHELLS_LOOT_PICKUP)
class _HWShellsPickupRibbon(_HWGameplayActionRibbon):
    BATTLE_EFFICIENCY_TYPE = HW_BATTLE_EFFICIENCY_TYPES.HALLOWEEN_SHELLS_PICKUP

    @property
    def isShowActionSource(self):
        return False

    def getFormatter(self):
        return _hwShellsPickupRibbonFormatter

    def _canAggregate(self, ribbon):
        return isinstance(ribbon, self.__class__) and ribbon.actionID == self.actionID


class HWRibbonsAggregator(RibbonsAggregator):
    FEEDBACK_EVENT_TO_RIBBON_CLS_FACTORY = _HW_FEEDBACK_EVENT_TO_RIBBON_CLS_FACTORY
    FEEDBACK_EVENTS_TO_IGNORE = _HW_FEEDBACK_EVENTS_TO_IGNORE
    RIBBON_TYPES_AGGREGATED_WITH_KILL_RIBBON = _HW_RIBBON_TYPES_AGGREGATED_WITH_KILL_RIBBON
    RIBBON_TYPES_COPY_TO = _HW_RIBBON_TYPES_COPY_TO

    def _aggregateRibbons(self, ribbons):
        copyMergedRibbons = []
        for destEffType, sourceClasses in self.RIBBON_TYPES_COPY_TO.iteritems():
            sourceRibbons = [ r for r in ribbons if r is not None and r.__class__ in sourceClasses ]
            destRibbons = [ r for r in ribbons if r is not None and r.getType() == destEffType ]
            for r in destRibbons:
                for other in sourceRibbons:
                    if r.aggregate(other) and getattr(other, 'hwIsMergeCopy', False):
                        copyMergedRibbons.append(other)

        return super(HWRibbonsAggregator, self)._aggregateRibbons([ r for r in ribbons if r not in copyMergedRibbons ])


class _HWStunAssistRibbon(_StunAssistRibbon):

    def getDamageSource(self):
        return DAMAGE_SOURCE.HIDE

    def _canAggregate(self, ribbon):
        return isinstance(ribbon, self.__class__)


@registerRibbonsFactory(FEEDBACK_EVENT_ID.PLAYER_ASSIST_TO_KILL_ENEMY)
class HWAssistToKillEnemyRibbonsFactory(_AssistRibbonClassFactory):

    def __init__(self):
        _AssistRibbonClassFactory.__init__(self, trackAssistCls=_TrackAssistRibbon, radioAssistCls=_RadioAssistRibbon, stunAssistCls=_HWStunAssistRibbon)


@registerRibbonsFactory(FEEDBACK_EVENT_ID.PLAYER_ASSIST_TO_STUN_ENEMY)
class HWAssistToStunEnemyRibbonsFactory(_AssistRibbonClassFactory):

    def __init__(self):
        _AssistRibbonClassFactory.__init__(self, trackAssistCls=_TrackAssistRibbon, radioAssistCls=_RadioAssistRibbon, stunAssistCls=_HWStunAssistRibbon)


class HWRibbonsAggregatorPlayer(HWRibbonsAggregator):

    def _onPlayerFeedbackReceived(self, events):
        if BattleReplay.g_replayCtrl.isTimeWarpInProgress:
            self.suspend()
        super(HWRibbonsAggregatorPlayer, self)._onPlayerFeedbackReceived(events)

    def _aggregateRibbons(self, ribbons):
        replayRibbons = []
        for ribbon in ribbons:
            if ribbon is None or BattleReplay.g_replayCtrl.isTimeWarpInProgress and ribbon.getType() not in _ACCUMULATED_RIBBON_TYPES:
                continue
            replayRibbons.append(ribbon)

        super(HWRibbonsAggregatorPlayer, self)._aggregateRibbons(replayRibbons)
        return


def createRibbonsAggregator():
    if BattleReplay.g_replayCtrl.isPlaying:
        return HWRibbonsAggregatorPlayer()
    return HWRibbonsAggregator()