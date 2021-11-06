import logging, BigWorld
from account_helpers.renewable_subscription import RenewableSubscription
from gui.shared.event_dispatcher import showWotPlusInfoPage
from web.web_client_api import W2CSchema, w2c
_logger = logging.getLogger(__name__)

class RenewableSubWebApiMixin(object):

    @w2c(W2CSchema, 'get_subscription_info')
    def getSubscriptionInfo(self, cmd):
        helper = BigWorld.player().renewableSubscription
        return {'period_start': helper.getStartTime(), 
           'period_end': helper.getExpiryTime()}

    @w2c(W2CSchema, 'subscription_info_window')
    def handleSubscriptionInfoWindow(self, cmd):
        showWotPlusInfoPage()