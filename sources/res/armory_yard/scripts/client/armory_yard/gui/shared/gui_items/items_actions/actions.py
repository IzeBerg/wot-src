from adisp import adisp_process, adisp_async
from armory_yard.gui.impl.gen.view_models.views.lobby.feature.armory_yard_reward_state import ArmoryYardRewardState
from armory_yard.gui.window_events import showArmoryYardRewardWindow
from gui.shared.gui_items.items_actions.actions import AsyncGUIItemAction
from armory_yard.gui.shared.gui_items.processors.armory_yard import CollectRewardsProcessor, BuyStepTokens
from gui.shared.utils import decorators

class CollectRewardsAction(AsyncGUIItemAction):

    def __init__(self, stageCount):
        super(CollectRewardsAction, self).__init__()
        self.skipConfirm = True
        self.__stageCount = stageCount

    @adisp_async
    @adisp_process
    def _action(self, callback):
        result = yield CollectRewardsProcessor().request()
        if result.success and result.auxData is not None:
            showArmoryYardRewardWindow(bonuses=result.auxData, state=ArmoryYardRewardState.STAGE, stage=self.__stageCount)
        callback(result)
        return


class BuyStepTokensAction(AsyncGUIItemAction):
    __slots__ = ('__count', )

    def __init__(self, count):
        super(BuyStepTokensAction, self).__init__()
        self.skipConfirm = True
        self.__count = count

    @adisp_async
    @decorators.adisp_process('buyItem')
    def _action(self, callback):
        result = yield BuyStepTokens(self.__count).request()
        callback(result)

    def _showResult(self, result):
        pass