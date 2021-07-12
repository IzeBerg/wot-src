from gui.shared.rq_cooldown import RequestCooldownManager, REQUEST_SCOPE
from messenger.proto.shared_errors import I18nActionID

class BattleCooldownManager(RequestCooldownManager):

    def __init__(self, default=1.0):
        super(BattleCooldownManager, self).__init__(REQUEST_SCOPE.BATTLE_ACTION)
        self.__default = default

    def lookupName(self, rqTypeID):
        return I18nActionID(rqTypeID).getI18nName()

    def getDefaultCoolDown(self):
        return self.__default