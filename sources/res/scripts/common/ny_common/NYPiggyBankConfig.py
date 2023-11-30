from typing import Dict, List, Optional, Callable
from ny_common.settings import NYPiggyBankConsts

class NYPiggyBankConfig(object):
    __slots__ = ('_config', )

    def __init__(self, config):
        self._config = config

    def getItems(self):
        return map(NYPiggyBankItem, self._config)

    def getItemByIndex(self, idx):
        if 0 <= idx < len(self._config):
            return NYPiggyBankItem(self._config[idx])
        else:
            return


class NYPiggyBankItem(object):
    __slots__ = ('_config', )

    def __init__(self, config):
        self._config = config

    def getID(self):
        return self._config.get(NYPiggyBankConsts.ID, None)

    def getDependencies(self):
        return self._config.get(NYPiggyBankConsts.DEPENDENCIES, None)

    def getRewards(self):
        return self._config.get(NYPiggyBankConsts.REWARDS, None)

    def isActiveItem(self, dependenciesChecker=None):
        dependencies = self.getDependencies()
        if dependenciesChecker is None or dependencies is None:
            return True
        return dependenciesChecker(dependencies)