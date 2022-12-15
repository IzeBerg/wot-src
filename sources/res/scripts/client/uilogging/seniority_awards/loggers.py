from uilogging.base.logger import MetricsLogger
from uilogging.constants import CommonLogActions
from uilogging.seniority_awards.constants import FEATURE, SeniorityAwardsLogItem, SeniorityAwardsLogParentScreen

class SeniorityAwardsLogger(MetricsLogger):
    __slots__ = ()

    def __init__(self):
        super(SeniorityAwardsLogger, self).__init__(FEATURE)

    def handleNotificationAction(self):
        self.log(action=CommonLogActions.CLICK, item=SeniorityAwardsLogItem.NOTIFICATION, parentScreen=SeniorityAwardsLogParentScreen.HANGAR)