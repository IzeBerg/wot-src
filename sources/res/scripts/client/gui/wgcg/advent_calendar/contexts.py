from gui.wgcg.base.contexts import CommonWebRequestCtx
from gui.wgcg.settings import WebRequestDataType

class AdventCalendarFetchHeroTankInfoCtx(CommonWebRequestCtx):

    def getRequestType(self):
        return WebRequestDataType.ADVENT_CALENDAR_FETCH_HERO_TANK_INFO

    def isAuthorizationRequired(self):
        return False

    def isClanSyncRequired(self):
        return False

    def isCaching(self):
        return False