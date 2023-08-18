import CGF, logging, BigWorld
from functools import partial
from Event import Event
from cgf_components_common.scenario.sequence_network_sync import SequenceNetworkSync as Sync
from script_component.DynamicScriptComponent import DynamicScriptComponent
from cgf_script.managers_registrator import onAddedQuery, autoregister, onProcessQuery, onRemovedQuery
from GenericComponents import Sequence
_logger = logging.getLogger(__name__)

class SequenceNetworkSync(DynamicScriptComponent, Sync):

    def __init__(self):
        super(SequenceNetworkSync, self).__init__()
        self.expired = False
        self.onStateChange = Event()

    @property
    def name(self):
        go = self.entity.entityGameObject
        if go is not None:
            return go.name
        else:
            return 'unknown'

    @property
    def actualTime(self):
        if self.state == int(Sequence.State.Paused):
            return self.syncTime
        return BigWorld.serverTime() - self.syncTime

    def set_state(self, prev):
        old = str(Sequence.State(prev))
        new = str(Sequence.State(self.state))
        _logger.debug('SequenceNetworkSync [%s] changing state [%s]->[%s]', self.name, old, new)
        self.onStateChange(self)


@autoregister(presentInAllWorlds=True, domain=CGF.DomainOption.DomainClient)
class SequenceNetworkSyncManager(CGF.ComponentManager):

    @onAddedQuery(SequenceNetworkSync, Sequence)
    def onControllerAdded(self, sync, seq):
        sync.onStateChange += partial(self.onStateChange, seq)
        self.onStateChange(seq, sync)

    @onRemovedQuery(SequenceNetworkSync)
    def onControllerRemoved(self, sync):
        sync.onStateChange.clear()

    @onProcessQuery(SequenceNetworkSync, Sequence, tickGroup='PreSimulation')
    def onProcess(self, sync, seq):
        if sync.state == int(Sequence.State.Stopped) and seq.state != Sequence.State.Stopped:
            seq.stop()
            return
        if sync.state == int(Sequence.State.Paused) or sync.state == int(Sequence.State.Running):
            self.__updateTime(sync, seq)

    def onStateChange(self, seq, sync):
        if sync.state == int(Sequence.State.Stopped):
            seq.stop()
            return
        if sync.state == int(Sequence.State.Running) or sync.state == int(Sequence.State.Paused):
            self.__updateTime(sync, seq)
            return
        _logger.warning('Unknown SequenceNetworkSync [%s] state', sync.name)

    def __updateTime(self, sync, seq):
        time = sync.actualTime
        if time >= seq.duration:
            time = seq.duration
        if seq.time != time:
            seq.setManualTime(time)