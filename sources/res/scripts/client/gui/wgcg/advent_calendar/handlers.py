from gui.wgcg.base.handlers import RequestHandlers
from gui.wgcg.settings import WebRequestDataType

class AdventCalendarRequestHandlers(RequestHandlers):

    def get(self):
        handlers = {WebRequestDataType.ADVENT_CALENDAR_FETCH_HERO_TANK_INFO: self.__fetchHeroTankInfo}
        return handlers

    def __fetchHeroTankInfo(self, ctx, callback):
        reqCtx = self._requester.doRequestEx(ctx, callback, ('advent_calendar', 'advent_calendar_fetch_hero_tank_info'))
        return reqCtx