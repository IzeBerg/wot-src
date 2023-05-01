import CGF, logging
from constants import IS_CLIENT
from cgf_script.managers_registrator import Rule, registerManager, registerRule
from cgf_demo.demo_category import DEMO_CATEGORY
from cgf_demo.test_bridge import TestBridgeManager
from cgf_demo.test_movers import TestAxisRotatorManager
from cgf_demo.test_triggers import TestTriggersManager, TestComponentCreationManager
if IS_CLIENT:
    from cgf_demo.test_edge_drawer import TestEdgeDrawerComponentManager
_logger = logging.getLogger(__name__)

@registerRule
class TestMapArenaManagerRule(Rule):
    category = DEMO_CATEGORY
    domain = CGF.DomainOption.DomainAll

    def __init__(self):
        super(TestMapArenaManagerRule, self).__init__()
        _logger.debug('TestMapArenaManagerRule Created')

    @registerManager(TestBridgeManager)
    def registerBridge(self):
        _logger.debug('TestBridgeManager Registrator')
        return

    @registerManager(TestAxisRotatorManager, domain=CGF.DomainOption.DomainClient | CGF.DomainOption.DomainServer)
    def registerAxisRotator(self):
        _logger.debug('TestAxisRotatorManager Registrator')
        return

    @registerManager(TestTriggersManager)
    def registerTriggerManager(self):
        _logger.debug('TestTriggersManager Registrator')
        return

    @registerManager(TestComponentCreationManager)
    def registerTestComponentCreationManager(self):
        _logger.debug('TestComponentCreationManager Registrator')
        return

    if IS_CLIENT:

        @registerManager(TestEdgeDrawerComponentManager)
        def registerEdgeDrawerComponentManager(self):
            _logger.debug('TestEdgeDrawerComponentManager Registrator')
            return