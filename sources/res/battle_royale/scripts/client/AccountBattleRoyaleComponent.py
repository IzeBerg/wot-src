import logging, BigWorld, BattleRoyaleConstants as brc
_logger = logging.getLogger(__name__)

class AccountBattleRoyaleComponent(BigWorld.StaticScriptComponent):

    def applyTestDrive(self, invID, callback=None):
        _logger.debug("apply test drive for: '%r'", invID)
        self.entity._doCmdIntStr(brc.CMD_BATTLE_ROYALE_TEST_DRIVE, invID, '', callback)

    def applyRent(self, invID, callback=None):
        _logger.debug("apply rent for: '%r'", invID)
        self.entity._doCmdIntStr(brc.CMD_BATTLE_ROYALE_RENT, invID, '', callback)

    def setBrCoin(self, amount, callback=None):
        _logger.debug("set battle royale coin amount: '%r'", amount)
        self.entity._doCmdIntStr(brc.CMD_BATTLE_ROYALE_OPERATE_BRCOIN, amount, '', callback)

    def setStpCoin(self, amount, callback=None):
        _logger.debug("set StPatrick coin amount: '%r'", amount)
        self.entity._doCmdIntStr(brc.CMD_BATTLE_ROYALE_OPERATE_STPCOIN, amount, '', callback)