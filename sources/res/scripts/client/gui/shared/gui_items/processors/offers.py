import logging
from functools import partial
import BigWorld
from gui import SystemMessages
from gui.Scaleform.Waiting import Waiting
from gui.shared.gui_items.processors import Processor, makeI18nError
from gui.shared.gui_items.processors.plugins import MessageConfirmator
from messenger.formatters.service_channel import QuestAchievesFormatter
_logger = logging.getLogger(__name__)

class ReceiveOfferGiftProcessor(Processor):

    def __init__(self, offerID, giftID, cdnTitle='', skipConfirm=False):
        self.__offerID = offerID
        self.__giftID = giftID
        plugins = [
         ReceiveGiftConfirmator(offerID, giftID, cdnTitle, isEnabled=not skipConfirm)]
        super(ReceiveOfferGiftProcessor, self).__init__(plugins)

    def _errorHandler(self, code, errStr='', ctx=None):
        Waiting.hide('loadContent')
        defaultKey = 'lootboxes/open/server_error'
        return makeI18nError(('/').join((defaultKey, errStr)), defaultKey)

    def _successHandler(self, code, ctx=None):
        Waiting.hide('loadContent')
        msg = QuestAchievesFormatter.formatQuestAchieves(ctx or {}, False)
        if msg is not None:
            SystemMessages.pushMessage(msg, type=SystemMessages.SM_TYPE.OfferGiftBonuses)
        return super(ReceiveOfferGiftProcessor, self)._successHandler(code, ctx)

    def _request(self, callback):
        _logger.debug('Make server request to receive offer gift. offerID=%s, giftID=%s', self.__offerID, self.__giftID)
        Waiting.show('loadContent')
        BigWorld.player().receiveOfferGift(self.__offerID, self.__giftID, lambda requestID, resultID, errStr, ext=None: self._response(resultID, callback, ctx=ext, errStr=errStr))
        return


class ReceiveGiftConfirmator(MessageConfirmator):

    def __init__(self, offerID, giftID, cdnTitle='', isEnabled=True):
        super(ReceiveGiftConfirmator, self).__init__(None, isEnabled=isEnabled)
        self._offerID = offerID
        self._giftID = giftID
        self._cdnTitle = cdnTitle
        return

    def _gfMakeMeta(self):
        from gui.shared import event_dispatcher
        return partial(event_dispatcher.showOfferGiftDialog, self._offerID, self._giftID, self._cdnTitle)