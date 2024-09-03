from gui.limited_ui.lui_rules_storage import LUI_RULES
from helpers import dependency
from skeletons.gui.game_control import ILimitedUIController

class LimitedUIHintChecker(object):

    def check(self, aliasId):
        limitedUIController = dependency.instance(ILimitedUIController)
        ruleID = LUI_RULES.lookup(aliasId)
        return ruleID is None or limitedUIController.isRuleCompleted(ruleID)