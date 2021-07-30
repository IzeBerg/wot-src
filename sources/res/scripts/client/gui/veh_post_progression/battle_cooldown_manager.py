from gui.shared.rq_cooldown import RequestCooldownManager, REQUEST_SCOPE

class BattleCooldownManager(RequestCooldownManager):

    def __init__(self, default=0.5):
        super(BattleCooldownManager, self).__init__(REQUEST_SCOPE.BATTLE_ACTION)
        self.__default = default

    def lookupName(self, rqTypeID):
        return ''

    def getDefaultCoolDown(self):
        return self.__default

    def _showSysMessage(self, msg):
        pass