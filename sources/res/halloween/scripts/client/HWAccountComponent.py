import logging, BigWorld, halloween_account_commands as hac
from halloween.skeletons.gui.game_event_controller import IHalloweenProgressController
from helpers import dependency
_logger = logging.getLogger(__name__)

class HWAccountComponent(BigWorld.StaticScriptComponent):
    _hwController = dependency.descriptor(IHalloweenProgressController)

    def applyDailyQuest(self, phase, callback=None):
        _logger.debug('apply daily quest')
        self.entity._doCmdInt(hac.CMD_HW_APPLY_DAILY_QUEST, phase, callback)

    def getHWProgressCtrl(self):
        return self._hwController