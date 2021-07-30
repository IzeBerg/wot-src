

class GFChannelViewInterface(object):

    def onChannelControllerInited(self, channelCtrl):
        pass

    def addMessageToView(self, message, isHistoryMessage=False):
        return False