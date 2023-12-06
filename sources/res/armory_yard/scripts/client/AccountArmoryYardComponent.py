import BigWorld, armory_yard_constants

class AccountArmoryYardComponent(BigWorld.StaticScriptComponent):

    def collectAllRewards(self, callback=None):
        self.entity._doCmdInt(armory_yard_constants.CMD_COLLECT_REWARDS, 0, callback)

    def buyStepTokens(self, currency, count, callback=None):
        self.entity._doCmdIntStr(armory_yard_constants.CMD_BUY_STEP_TOKENS, count, currency, callback)

    def devAddToken(self, count, callback=None):
        self.entity._doCmdInt(armory_yard_constants.DEV_CMD_ADD_TOKEN_S, count, callback)

    def devCompleteQuest(self, cycle, number, callback=None):
        self.entity._doCmdInt2(armory_yard_constants.DEV_CMD_SET_QUEST, cycle, number, callback)

    def devCompleteCycle(self, cycle, callback=None):
        self.entity._doCmdInt(armory_yard_constants.DEV_CMD_SET_CYCLE, cycle, callback)

    def claimFinalReward(self, callback=None):
        self.entity._doCmdInt(armory_yard_constants.CMD_CLAIM_FINAL_REWARD, 0, callback)