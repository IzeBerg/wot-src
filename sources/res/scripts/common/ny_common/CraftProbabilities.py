from typing import Tuple
from ny_common.settings import CraftProbsConsts

class CraftProbabilitiesConfig(object):
    __slots__ = ('_config', )

    def __init__(self, config=None):
        self._config = config or {}

    def getProbabilitiesForTypes(self):
        return self._config.get(CraftProbsConsts.TYPE_PROBABILITIES, ())

    def getProbabilitiesForSettings(self):
        return self._config.get(CraftProbsConsts.SETTING_PROBABILITIES, ())

    def getProbabilitiesForRanks(self):
        return self._config.get(CraftProbsConsts.RANK_PROBABILITIES, ())