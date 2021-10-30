import aspects
from helpers import aop

class IsPersonalMissionsEnabled(aop.Pointcut):

    def __init__(self):
        aop.Pointcut.__init__(self, 'helpers.server_settings', 'ServerSettings', 'isPersonalMissionsEnabled', aspects=(
         aspects.IsPersonalMissionsEnabled,))