from ny_common.settings import ResourceCollectingConsts
from typing import Optional, List, Dict, Union

class ResourceCollectingConfig(object):

    def __init__(self, config):
        self._config = config

    def getCollectingsDescriptors(self):
        return map(CollectingDescriptor, self._config.get(ResourceCollectingConsts.COLLECTINGS))

    def getCollectingDescriptorByIndex(self, idx):
        collectings = self._config.get(ResourceCollectingConsts.COLLECTINGS)
        if collectings and 0 <= idx < len(collectings):
            return CollectingDescriptor(collectings[idx])
        else:
            return

    def getNextCollectingDescriptor(self, activeIndex):
        collectings = self._config.get(ResourceCollectingConsts.COLLECTINGS)
        if collectings is None or len(collectings) == 0:
            return
        if activeIndex is None:
            return CollectingDescriptor(collectings[0])
        else:
            return CollectingDescriptor(collectings[(activeIndex + 1 if len(collectings) > activeIndex + 1 else 0)])

    def getFriendResources(self):
        return self._config.get(ResourceCollectingConsts.FRIEND_RESOURCES, {})


class CollectingDescriptor(object):

    def __init__(self, config):
        self._config = config

    def getID(self):
        return self._config.get(ResourceCollectingConsts.COLLECTING_ID)

    def getResources(self):
        return self._config.get(ResourceCollectingConsts.RESOURCES, {})

    def getCollectingByType(self, type):
        collectingType = self._config.get(ResourceCollectingConsts.COLLECTING_TYPES, {}).get(type)
        if collectingType is None:
            return
        else:
            return ResourceCollectingType(collectingType)

    def getCollectingCooldown(self):
        return self._config.get(ResourceCollectingConsts.COOLDOWN, None)


class ResourceCollectingType(object):

    def __init__(self, config):
        self._config = config

    def getPrice(self):
        return self._config.get(ResourceCollectingConsts.COLLECTING_PRICE, {})