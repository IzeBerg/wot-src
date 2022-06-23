from gui.wgcg.settings import WebRequestDataType

class RequestHandlers(object):

    def __init__(self, requester):
        self._requester = requester


class BaseRequestHandlers(RequestHandlers):

    def get(self):
        handlers = {WebRequestDataType.LOGIN: self.__login, 
           WebRequestDataType.LOGOUT: self.__logout, 
           WebRequestDataType.PING: self.__ping}
        return handlers

    def __login(self, ctx, callback=None):
        return self._requester.doRequestEx(ctx, callback, 'login', ctx.getUserDatabaseID(), ctx.getTokenID(), ctx.isJwt())

    def __logout(self, ctx, callback=None):
        return self._requester.doRequestEx(ctx, callback, 'logout')

    def __ping(self, ctx, callback=None):
        return self._requester.doRequestEx(ctx, callback, 'get_alive_status')