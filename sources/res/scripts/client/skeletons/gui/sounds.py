

class ISoundsController(object):

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def start(self):
        raise NotImplementedError

    def stop(self, isDisconnected=False):
        raise NotImplementedError

    @property
    def system(self):
        raise NotImplementedError

    def enable(self):
        raise NotImplementedError

    def disable(self):
        raise NotImplementedError

    def isEnabled(self):
        raise NotImplementedError

    def setEnvForSpace(self, spaceID, newEnv):
        raise NotImplementedError


class IVehicleHitSound(object):

    def getSoundStringFromHitFlags(self, enemyVehID, hitFlags, enemiesHitCount):
        raise NotImplementedError