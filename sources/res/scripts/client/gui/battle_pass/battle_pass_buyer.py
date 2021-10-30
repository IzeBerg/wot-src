from gui import SystemMessages
from adisp import async, process
from gui.shop import showBuyGoldForBattlePass, showBuyGoldForBattlePassLevels
from gui.shared.gui_items.processors.common import BuyBattlePass, BuyBattlePassLevels
from gui.shared.utils import decorators
from gui.shared.money import Currency
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController, ISoundEventChecker
from skeletons.gui.shared import IItemsCache

class BattlePassBuyer(object):
    __itemsCache = dependency.descriptor(IItemsCache)
    __battlePassController = dependency.descriptor(IBattlePassController)
    __soundEventChecker = dependency.descriptor(ISoundEventChecker)

    @classmethod
    @decorators.process('buyBattlePass')
    def buyBP(cls, seasonID, chapter=None, onBuyCallback=None):
        spendMoneyGold = 0
        if chapter is None:
            chapter = 0
        if not cls.__battlePassController.isBought():
            spendMoneyGold += cls.__itemsCache.items.shop.getBattlePassCost().get(Currency.GOLD, 0)
        result = False
        if cls.__itemsCache.items.stats.actualGold < spendMoneyGold:
            showBuyGoldForBattlePass(spendMoneyGold)
        else:
            result = yield cls.__buyBattlePass(seasonID, chapter)
        if onBuyCallback:
            onBuyCallback(result)
        return

    @classmethod
    @decorators.process('buyBattlePassLevels')
    def buyLevels(cls, seasonID, levels=0, onBuyCallback=None):
        spendMoneyGold = 0
        if levels > 0:
            spendMoneyGold += cls.__itemsCache.items.shop.getBattlePassLevelCost().get(Currency.GOLD, 0) * levels
        result = False
        if cls.__itemsCache.items.stats.actualGold < spendMoneyGold:
            showBuyGoldForBattlePassLevels(spendMoneyGold)
        else:
            cls.__soundEventChecker.lockPlayingSounds()
            result = yield cls.__buyBattlePassLevels(seasonID, levels)
            cls.__soundEventChecker.unlockPlayingSounds()
        if onBuyCallback:
            onBuyCallback(result)

    @classmethod
    @async
    @process
    def __buyBattlePass(cls, seasonID, chapter, callback):
        result = yield BuyBattlePass(seasonID, chapter).request()
        startLevel, _ = cls.__battlePassController.getChapterLevelInterval(chapter)
        if cls.__battlePassController.getCurrentLevel() != startLevel - 1:
            callback(result.success)
            return
        else:
            if result.userMsg is not None:
                SystemMessages.pushMessage(result.userMsg, type=result.sysMsgType, messageData=result.auxData)
            callback(result.success)
            return

    @staticmethod
    @async
    @process
    def __buyBattlePassLevels(seasonID, levels, callback):
        result = yield BuyBattlePassLevels(seasonID, levels).request()
        if result.userMsg:
            SystemMessages.pushMessage(result.userMsg, type=result.sysMsgType)
        callback(result.success)