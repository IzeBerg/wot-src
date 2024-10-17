import BigWorld
from gui.Scaleform.daapi.view.battle.shared.status_notifications import sn_items
from gui.Scaleform.daapi.view.battle.shared.status_notifications.sn_items import VehicleStateSN, TimerSN, HalfOverturnedSN, StaticDeathZoneSN
from halloween.gui.battle_control.halloween_battle_constants import VEHICLE_VIEW_STATE
from gui.impl import backport
from gui.impl.gen import R
from halloween.gui.scaleform.genConsts.HW_BATTLE_NOTIFICATIONS_TIMER_TYPES import HW_BATTLE_NOTIFICATIONS_TIMER_TYPES as _HWTYPES
from helpers.CallbackDelayer import CallbackDelayer

class _HalloweenLocalizationProvider(sn_items.LocalizationProvider):

    @property
    def _stringResource(self):
        return R.strings.halloween_battle.statusNotificationTimers


class FullCollectorSN(_HalloweenLocalizationProvider, VehicleStateSN):

    def getItemID(self):
        return VEHICLE_VIEW_STATE.COLLECTOR_FULL

    def getViewTypeID(self):
        return _HWTYPES.MAGNUS_WAIT

    def _getDescription(self, value):
        return backport.text(self._stringResource.collectorFull())

    def _update(self, value):
        if value:
            self._isVisible = True
            self._sendUpdate()
            return
        self._setVisible(False)


class PhaseFinishSN(_HalloweenLocalizationProvider, TimerSN):

    def getItemID(self):
        return VEHICLE_VIEW_STATE.PHASE_END

    def getViewTypeID(self):
        return _HWTYPES.MAGNUS_GOTO

    def _getDescription(self, value):
        _, isCollectorFull = value
        if isCollectorFull:
            return backport.text(self._stringResource.phaseEnd())
        return ''

    def _update(self, value):
        duration, _ = value
        if duration:
            self._updateTimeParams(duration, 0)
            self._isVisible = True
            self._sendUpdate()
            return
        self._setVisible(False)


class HWHalfOverturnedSN(_HalloweenLocalizationProvider, HalfOverturnedSN):

    def _getDescription(self, value=None):
        return backport.text(self._stringResource.overturned())


class HWStaticDeathZoneSN(StaticDeathZoneSN):

    def getViewTypeID(self):
        return _HWTYPES.HW_DEATH_ZONE


class HWDrainedSoulsSN(sn_items.FireSN):

    def getItemID(self):
        return VEHICLE_VIEW_STATE.HW_DRAIN_SOULS

    def getViewTypeID(self):
        return _HWTYPES.HW_DRAIN_SOULS

    def _getDescription(self, value=None):
        return backport.text(R.strings.halloween_battle.bossAura.leaveDamageAreaWarningSouls())


class HWDrainedLifeSN(sn_items.FireSN):

    def getItemID(self):
        return VEHICLE_VIEW_STATE.HW_DRAIN_LIFE

    def getViewTypeID(self):
        return _HWTYPES.HW_DRAIN_LIFE

    def _getDescription(self, value=None):
        return backport.text(R.strings.halloween_battle.bossAura.leaveDamageAreaWarningHealth())


class HWPersonalDeathZoneSN(_HalloweenLocalizationProvider, TimerSN):

    def __init__(self, updateCallback):
        super(HWPersonalDeathZoneSN, self).__init__(updateCallback)
        self.__callbackDelayer = CallbackDelayer()

    def destroy(self):
        self.__callbackDelayer.destroy()
        super(HWPersonalDeathZoneSN, self).destroy()

    def getItemID(self):
        return VEHICLE_VIEW_STATE.PERSONAL_DEATHZONE

    def getViewTypeID(self):
        return _HWTYPES.HW_PERSONAL_DEATH_ZONE

    def _getDescription(self, value):
        return backport.text(self._stringResource.personalDeathZone())

    def _update(self, value):
        self.__callbackDelayer.clearCallbacks()
        visible, strikeDelay, launchTime = value
        if visible:
            finishTime = launchTime + strikeDelay
            self._updateTimeParams(strikeDelay, finishTime)
            if strikeDelay > 0:
                self.__callbackDelayer.delayCallback(finishTime - BigWorld.serverTime(), self.__hideTimer)
            self._isVisible = True
            self._sendUpdate()
            return
        self._setVisible(False)

    def __hideTimer(self):
        params = (
         self._isVisible, 0, 0)
        self._update(params)