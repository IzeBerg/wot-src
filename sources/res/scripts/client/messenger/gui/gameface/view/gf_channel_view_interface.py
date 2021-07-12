

class GFChannelViewInterface(object):

    def onChannelControllerInited(self, channelCtrl):
        pass

    def addMessageToView(self, message):
        return False