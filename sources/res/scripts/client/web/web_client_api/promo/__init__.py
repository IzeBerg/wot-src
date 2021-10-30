from helpers import dependency
from skeletons.gui.game_control import IPromoController
from web.web_client_api import w2c, w2capi, W2CSchema, Field

class _PromoCountSchema(W2CSchema):
    count = Field(required=True, type=int)


@w2capi(name='promo', key='action')
class PromoWebApi(object):
    _promoCtrl = dependency.descriptor(IPromoController)

    @w2c(_PromoCountSchema, 'unread_count')
    def promoCount(self, cmd):
        self._promoCtrl.setUnreadPromoCount(cmd.count)