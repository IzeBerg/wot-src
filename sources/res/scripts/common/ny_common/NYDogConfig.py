from typing import Optional, List, Dict, Tuple
from ny_common.settings import NYDogConsts

class NYDogConfig(object):
    __slots__ = ('_config', )

    def __init__(self, config):
        self._config = config

    def getTokenName(self):
        return self._config.get(NYDogConsts.TOKEN_NAME)

    def getLevels(self):
        return self._config.get(NYDogConsts.LEVELS, [])

    def _getLevelOrNone(self, level):
        levels = self.getLevels()
        if level < 0 or level >= len(levels):
            return None
        return levels[level]

    def getLevelLootboxCategory(self, level):
        levelConfig = self._getLevelOrNone(level)
        if levelConfig:
            return levelConfig.get(NYDogConsts.LEVEL_LOOTBOX)
        else:
            return

    def getLevelPrice(self, level):
        levelConfig = self._getLevelOrNone(level)
        if levelConfig:
            return levelConfig.get(NYDogConsts.LEVEL_PRICE)
        else:
            return

    def getLevelToys(self, level):
        levelConfig = self._getLevelOrNone(level)
        if levelConfig:
            return levelConfig.get(NYDogConsts.LEVEL_TOYS)
        else:
            return