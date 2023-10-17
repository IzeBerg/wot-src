from gui.wgcg.base.handlers import RequestHandlers
from gui.wgcg.settings import WebRequestDataType

class WinBackCallRequestHandlers(RequestHandlers):

    def get(self):
        handlers = {WebRequestDataType.WIN_BACK_CALL_FRIENDS: self.__getWinBackCallFriendList, 
           WebRequestDataType.WIN_BACK_CALL_SEND_INVITE_CODE: self.__winBackCallSendInviteCode}
        return handlers

    def __getWinBackCallFriendList(self, ctx, callback):
        return self._requester.doRequestEx(ctx, callback, ('win_back_call', 'get_win_back_call_friend_list'))

    def __winBackCallSendInviteCode(self, ctx, callback):
        return self._requester.doRequestEx(ctx, callback, ('win_back_call', 'win_back_call_send_invite_code'), ctx.getSpaID())