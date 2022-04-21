from web.web_client_api import w2c, W2CSchema
from gui.shared import event_dispatcher as shared_events

class RtsMetaViewsWebApiMixin(object):

    @w2c(W2CSchema, 'rts_collection')
    def openRTSCollectionView(self, _):
        shared_events.showRTSMetaRootWindow()