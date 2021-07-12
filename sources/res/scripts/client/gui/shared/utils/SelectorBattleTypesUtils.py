from account_helpers.AccountSettings import AccountSettings, KNOWN_SELECTOR_BATTLES

def setBattleTypeAsKnown(bType):
    selectorKnownBattles = set(AccountSettings.getSettings(KNOWN_SELECTOR_BATTLES))
    selectorKnownBattles.add(bType)
    AccountSettings.setSettings(KNOWN_SELECTOR_BATTLES, selectorKnownBattles)


def isKnownBattleType(bType):
    selectorKnownBattles = set(AccountSettings.getSettings(KNOWN_SELECTOR_BATTLES))
    return bType in selectorKnownBattles