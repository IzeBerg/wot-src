import typing, BigWorld
from gui.battle_control.controllers.spam_protection.spam_constants import DEFAULT_COOLDOWN

class SpamCooldownManager(object):

    def __init__(self):
        self.__cooldowns = {}

    def destroy(self):
        self.__cooldowns.clear()

    def isInProcess(self, eventKey):
        if eventKey in self.__cooldowns:
            return self.__cooldowns[eventKey] > BigWorld.time()
        return False

    def process(self, eventKey, coolDown=None):
        coolDown = coolDown or DEFAULT_COOLDOWN
        self.__cooldowns[eventKey] = BigWorld.time() + coolDown