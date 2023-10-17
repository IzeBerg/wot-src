import BigWorld
from web.web_client_api import w2c, W2CSchema

class OpenHalloweenMixin(object):

    @w2c(W2CSchema, 'halloween2023')
    def selectHalloweenMode(self, _):
        component = getattr(BigWorld.player(), 'HalloweenAccountComponent', None)
        if component and component.getHalloweenController().isAvailable():
            component.getHalloweenController().openHangar()
        return