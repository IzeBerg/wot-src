import CGF
from cgf_demo.demo_category import DEMO_CATEGORY
from cgf_demo_client.test_hierarchy_modificator import ModelSwapperManager
from cgf_demo_client.test_state_machine_trigger import StateMachineActivatorManager
from cgf_demo_client.test_triggers import EntranceModifierManager, TestHealthMonitoringManager
from cgf_script.managers_registrator import Rule, registerManager, registerRule
from cgf_demo_client.test_physical_debris_spawner import EntranceSpawnerManager
from cgf_demo_client.test_gun_effects_controller import EntranceSingleShotManager, EntranceContinuousBurstManager
from constants import IS_CLIENT
if IS_CLIENT:
    from TestReplicableComponent import DisplayReplicableValuesManager
else:

    class DisplayReplicableValuesManager(object):
        pass


@registerRule
class TestClientDemoRules(Rule):
    category = DEMO_CATEGORY
    domain = CGF.DomainOption.DomainAll

    @registerManager(EntranceModifierManager)
    def registerEntranceModifier(self):
        return

    @registerManager(StateMachineActivatorManager)
    def registerStateActivator(self):
        return

    @registerManager(ModelSwapperManager)
    def registerModelSwapper(self):
        return

    @registerManager(DisplayReplicableValuesManager, domain=CGF.DomainOption.DomainClient)
    def registerDisplayReplicable(self):
        return

    @registerManager(EntranceSpawnerManager)
    def registerEntranceSpawner(self):
        return

    @registerManager(EntranceSingleShotManager)
    def registerEntranceSingleShotManager(self):
        return

    @registerManager(EntranceContinuousBurstManager)
    def registerEntranceContinuousBurstManager(self):
        return

    @registerManager(TestHealthMonitoringManager)
    def registerHealthMonitorManager(self):
        return