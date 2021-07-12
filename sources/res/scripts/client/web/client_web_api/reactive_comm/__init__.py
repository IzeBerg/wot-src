import json
from helpers import dependency
from skeletons.gui.game_control import IReactiveCommunicationService
from web.client_web_api.api import C2WHandler, c2w

class ReactiveCommunicationEventHandler(C2WHandler):
    __service = dependency.descriptor(IReactiveCommunicationService)

    def init(self):
        super(ReactiveCommunicationEventHandler, self).init()
        self.__service.onChannelMessage += self.__onChannelMessage
        self.__service.onSubscriptionClosed += self.__onSubscriptionClosed

    def fini(self):
        self.__service.onChannelMessage -= self.__onChannelMessage
        self.__service.onSubscriptionClosed -= self.__onSubscriptionClosed
        super(ReactiveCommunicationEventHandler, self).fini()

    def sendWebEvent(self, webEvent):
        sender = self.getSender()
        if sender is not None:
            try:
                sender.sendEvent(json.dumps(webEvent))
            except ReferenceError:
                return

        return

    @c2w(name='on_reactive_communication_channel_message')
    def __onChannelMessage(self, name, message):
        return {'channel_name': name, 
           'data': message}

    @c2w(name='on_reactive_communication_subscription_closed')
    def __onSubscriptionClosed(self, subscription, reason):
        return {'channel_name': subscription.channel, 
           'subscription_id': id(subscription), 
           'reason': reason.value}