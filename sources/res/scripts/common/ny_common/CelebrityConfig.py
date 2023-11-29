from ny_common.settings import CelebrityConsts
from typing import Optional, Dict, Set

class CelebrityConfig(object):
    __slots__ = ('_config', )

    def __init__(self, config):
        self._config = config

    def getQuestCount(self):
        return self._config.get(CelebrityConsts.QUEST_COUNT, 0)