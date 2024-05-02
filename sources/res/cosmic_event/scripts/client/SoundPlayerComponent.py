import typing
from cosmic_event_common.cosmic_constants import PhaseTypes
from script_component.DynamicScriptComponent import DynamicScriptComponent
from helpers.events_handler import EventsHandler
from cosmic_event.gui.shared.events import FragmentEvent, ProgressBarEvent, ZoneEvent, VehicleEvent
from gui.shared import EVENT_BUS_SCOPE, EventPriority, g_eventBus
from cosmic_sound import CosmicBattleSounds
from constants import ARENA_PERIOD
from PlayerEvents import g_playerEvents
if typing.TYPE_CHECKING:
    from gui.shared.event_bus import SharedEvent
SOUND_BY_EVENT_TYPE = {FragmentEvent.FRAGMENT_COLLECTED: CosmicBattleSounds.Fragment.playFragmentPickup, 
   FragmentEvent.FRAGMENT_FULL: CosmicBattleSounds.Fragment.playFragmentFull, 
   ZoneEvent.ON_VEHICLE_ENTER: CosmicBattleSounds.Zones.playOnVehicleEnter, 
   ZoneEvent.ON_VEHICLE_LEAVE: CosmicBattleSounds.Zones.playOnVehicleLeave, 
   ZoneEvent.ON_FRAGMENTS_DELIVERED: CosmicBattleSounds.Zones.playOnFragmentsDelivered}
if typing.TYPE_CHECKING:
    from typing import List, Union

class SoundPlayerComponent(DynamicScriptComponent, EventsHandler):

    def _subscribe(self):
        g_playerEvents.onArenaPeriodChange += self.onPeriodChange
        super(SoundPlayerComponent, self)._subscribe()

    def _unsubscribe(self):
        g_playerEvents.onArenaPeriodChange -= self.onPeriodChange
        super(SoundPlayerComponent, self)._unsubscribe()

    def onPeriodChange(self, period, periodEndTime, periodLength, *args):
        if period == ARENA_PERIOD.BATTLE:
            CosmicBattleSounds.startBattlePeriodMusic()
        elif period == ARENA_PERIOD.AFTERBATTLE:
            CosmicBattleSounds.startAfterBattlePeriodMusic()

    def _onAvatarReady(self):
        self._subscribe()

    def onDestroy(self):
        super(SoundPlayerComponent, self).onDestroy()
        self._unsubscribe()

    def _getListeners(self):
        listeners = [
         (
          FragmentEvent.FRAGMENT_COLLECTED,
          self._playEventSound,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          FragmentEvent.FRAGMENT_FULL,
          self._playEventSound,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          ProgressBarEvent.PHASE_CHANGED,
          self._onPhaseChanged,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.DEFAULT),
         (
          ZoneEvent.ON_VEHICLE_ENTER,
          self._playEventSound,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.DEFAULT),
         (
          ZoneEvent.ON_VEHICLE_LEAVE,
          self._playEventSound,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          ZoneEvent.ON_FRAGMENTS_DELIVERED,
          self._playEventSound,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          VehicleEvent.VEHICLE_EVACUATED,
          self._unsubscribeEvacuationSound,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH)]
        return listeners

    def _playEventSound(self, event):
        SOUND_BY_EVENT_TYPE[event.eventType]()

    def _onPhaseChanged(self, event):
        phaseType = event.ctx.get('phaseType')
        previousPhaseType = event.ctx.get('previousPhaseType')
        if phaseType == PhaseTypes.DELIVERY:
            CosmicBattleSounds.Zones.playDeliveryStarted()
        elif phaseType == PhaseTypes.EVACUATION:
            CosmicBattleSounds.Zones.playEvacuationStarted()
        elif phaseType == PhaseTypes.IDLE and previousPhaseType == PhaseTypes.DELIVERY:
            CosmicBattleSounds.Zones.playDeliveryFinished()

    def _unsubscribeEvacuationSound(self, _):
        g_eventBus.removeListener(ZoneEvent.ON_VEHICLE_LEAVE, self._playEventSound, EVENT_BUS_SCOPE.BATTLE)