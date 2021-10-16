from gui.wgcg.base.handlers import RequestHandlers
from gui.wgcg.settings import WebRequestDataType

class YhaRequestHandlers(RequestHandlers):

    def get(self):
        handlers = {WebRequestDataType.YHA_VIDEO: self.__getYhaVideo}
        return handlers

    def __getYhaVideo(self, ctx, callback):
        return self._requester.doRequestEx(ctx, callback, ('yha', 'get_yha_video'))