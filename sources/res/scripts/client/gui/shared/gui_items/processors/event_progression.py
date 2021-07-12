import logging, typing, BigWorld
from gui.SystemMessages import SM_TYPE
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.gui_items.processors import makeI18nError, makeI18nSuccess, plugins, Processor
from helpers import dependency, time_utils
from messenger.formatters import TimeFormatter
from skeletons.gui.game_control import IEventProgressionController
from soft_exception import SoftException
_logger = logging.getLogger(__name__)

def _skipResponse(resultID, errorCode):
    _logger.debug('_skipResponse, resultID: %s, errorCode: %s', resultID, errorCode)


class _EventProgressionBuyReward(Processor):

    def __init__(self, reward):
        self._reward = reward
        super(_EventProgressionBuyReward, self).__init__((RewardPointsValidator(self.getPrice()),))

    def getID(self):
        raise NotImplementedError

    def getName(self):
        raise NotImplementedError

    def getPrice(self):
        raise NotImplementedError

    def _buy(self, callback=_skipResponse):
        raise NotImplementedError

    def _getErrorMessageKey(self):
        raise NotImplementedError

    def _getSuccessMessageKey(self):
        raise NotImplementedError

    def _errorHandler(self, code, errStr='', ctx=None):
        return makeI18nError(sysMsgKey=self._getErrorMessageKey(), type=SM_TYPE.Error, **self.__getMsgCtx())

    def _successHandler(self, code, ctx=None):
        return makeI18nSuccess(sysMsgKey=self._getSuccessMessageKey(), type=SM_TYPE.FrontlineRewards, **self.__getMsgCtx())

    def _request(self, callback):
        _logger.debug('Make server request to buy event progression reward, reward id: %s', self.getID())
        self._buy(lambda code, errCode: self._response(code, callback, errStr=errCode))

    def __getMsgCtx(self):
        return {'name': self.getName(), 
           'count': self.getPrice(), 
           'date': self.__formatTime()}

    @staticmethod
    def __formatTime():
        operationTime = time_utils.getCurrentLocalServerTimestamp()
        if operationTime:
            return TimeFormatter.getLongDatetimeFormat(operationTime)
        return 'N/A'


class RewardPointsValidator(plugins.SyncValidator):
    __eventProgression = dependency.descriptor(IEventProgressionController)

    def __init__(self, price):
        super(RewardPointsValidator, self).__init__()
        self.__price = price

    def _validate(self):
        if self.__price and self.__eventProgression.actualRewardPoints >= self.__price:
            return plugins.makeSuccess()
        return plugins.makeError('ne_points')


class _EventProgressionBuyRewardVehicle(_EventProgressionBuyReward):
    __eventProgression = dependency.descriptor(IEventProgressionController)

    def getID(self):
        return self._reward.intCD

    def getName(self):
        return self._reward.shortUserName

    def getPrice(self):
        return self.__eventProgression.getRewardVehiclePrice(self.getID())

    def _buy(self, callback=_skipResponse):
        BigWorld.player().epicMetaGame.buyFrontlineRewardVehicle(self.getID(), callback)

    def _getErrorMessageKey(self):
        return 'event_progression_buy_vehicle/server_error'

    def _getSuccessMessageKey(self):
        return 'event_progression_buy_vehicle/success'


class _EventProgressionBuyRewardStyle(_EventProgressionBuyReward):
    __eventProgression = dependency.descriptor(IEventProgressionController)

    def getID(self):
        return self._reward.id

    def getName(self):
        return self._reward.userName

    def getPrice(self):
        return self.__eventProgression.getRewardStylePrice(self.getID())

    def _buy(self, callback=_skipResponse):
        BigWorld.player().epicMetaGame.buyFrontlineRewardStyle(self.getID(), callback)

    def _getErrorMessageKey(self):
        return 'event_progression_buy_style/server_error'

    def _getSuccessMessageKey(self):
        return 'event_progression_buy_style/success'


_BUY_REWARD_REQUESTER = {GUI_ITEM_TYPE.VEHICLE: _EventProgressionBuyRewardVehicle, 
   GUI_ITEM_TYPE.STYLE: _EventProgressionBuyRewardStyle}

def getEventProgressionRewardRequester(reward):
    requester = _BUY_REWARD_REQUESTER.get(reward.itemTypeID)
    if requester is None:
        raise SoftException('reward.itemTypeID: %s is not supported', reward.itemTypeID)
    return requester(reward)