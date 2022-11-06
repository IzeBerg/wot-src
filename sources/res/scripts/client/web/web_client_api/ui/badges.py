from web.web_client_api import w2c, W2CSchema
from gui.shared import event_dispatcher as shared_events

class BadgesWebApiMixin(object):

    @w2c(W2CSchema, 'badges')
    def openBadges(self, cmd):
        shared_events.showBadges()