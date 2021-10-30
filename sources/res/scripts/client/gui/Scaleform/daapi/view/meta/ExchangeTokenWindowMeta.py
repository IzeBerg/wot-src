from gui.Scaleform.daapi.view.lobby.exchange.ExchangeWindow import ExchangeWindow

class ExchangeTokenWindowMeta(ExchangeWindow):

    def as_setExchangePropertiesS(self, primary, secondary, flipRate):
        if self._isDAAPIInited():
            return self.flashObject.as_setExchangeProperties(primary, secondary, flipRate)