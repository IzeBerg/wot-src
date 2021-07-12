from web.web_client_api import w2c, W2CSchema
from gui.shared import event_dispatcher as shared_events

class BarracksWebApiMixin(object):

    @w2c(W2CSchema, 'barracks')
    def openBarracks(self, cmd):
        shared_events.showBarracks()