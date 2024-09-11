from gui.shared.gui_items.items_actions.factory import registerAction
from armory_yard.gui.shared.gui_items.items_actions.actions import CollectRewardsAction, BuyStepTokensAction
COLLECT_REWARDS = 'collectRewards'
BUY_STEP_TOKENS = 'buyStepTokens'
BUY_POST_PROGRESSION_TOKENS = 'buyStepTokens'

def registerActions():
    registerAction(COLLECT_REWARDS, CollectRewardsAction)
    registerAction(BUY_STEP_TOKENS, BuyStepTokensAction)