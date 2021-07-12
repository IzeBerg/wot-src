from gui.shared import event_dispatcher
from gui.shared.event_dispatcher import hideWebBrowserOverlay
from web.web_client_api import w2c, W2CSchema, Field

class _OpenShopSchema(W2CSchema):
    path = Field(required=False, type=basestring)


class ShopWebApiMixin(object):

    @w2c(_OpenShopSchema, 'shop')
    def openShop(self, cmd):
        hideWebBrowserOverlay()
        event_dispatcher.showShop(path=cmd.path)