import logging
from helpers import dependency
from constants import QUEUE_TYPE
from daily_quest_widget import DailyQuestWidget
from gui.impl.lobby.missions.rts_quests_widget_view import RtsQuestsWidgetView
from skeletons.gui.game_control import IRTSProgressionController
from skeletons.gui.game_control import IRTSBattlesController
_logger = logging.getLogger(__name__)

class RtsQuestWidget(DailyQuestWidget):
    __progressionCtrl = dependency.descriptor(IRTSProgressionController)
    __battlesController = dependency.instance(IRTSBattlesController)

    def onPrbEntitySwitched(self):
        if not self._isRTSSelected():
            self._animateHide()
        else:
            self._showOrHide()

    def _makeInjectView(self):
        return RtsQuestsWidgetView()

    def _shouldHide(self):
        return not self.__progressionCtrl.isEnabled() or self.promoController.isTeaserOpen() or not self._isRTSSelected()

    def _isRTSSelected(self):
        queueType = self.__getQueueType()
        return queueType == QUEUE_TYPE.RTS or queueType == QUEUE_TYPE.RTS_1x1

    def _getQuests(self):
        isCommander = self.__battlesController.isCommander()
        return self.__progressionCtrl.getQuests(isCommander, includeFuture=False)

    def __getQueueType(self):
        if self.prbEntity:
            return self.prbEntity.getQueueType()
        return QUEUE_TYPE.UNKNOWN

    def _executeShowOrHide(self):
        if self._shouldHide():
            self._hide()
            return
        self._show()