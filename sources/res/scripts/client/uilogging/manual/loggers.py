from uilogging.base.logger import BaseLogger
from uilogging.manual.constants import FEATURE

class ManualLogger(BaseLogger):

    def __init__(self, group):
        super(ManualLogger, self).__init__(FEATURE, group)