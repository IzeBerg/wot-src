from constants import EMAIL_CONFIRMATION_QUEST_ID
from gui.shared.missions.packers.bonus import packBonusModelAndTooltipData, getDefaultBonusPacker
from gui.shared.money import Currency
from helpers import dependency
from skeletons.gui.server_events import IEventsCache
_BONUSES_ORDER = (
 'vehicles', 'premium', Currency.CRYSTAL, Currency.GOLD, 'freeXP', 'freeXPFactor',
 Currency.CREDITS, 'creditsFactor', 'tankmen', 'items', 'slots', 'berths', 'dossier',
 'customizations', 'tokens', 'goodies', Currency.EVENT_COIN)

def _keyBonusesOrder(bonus):
    if bonus.getName() in _BONUSES_ORDER:
        return _BONUSES_ORDER.index(bonus.getName())
    return len(_BONUSES_ORDER)


def getBonuses():
    eventsCache = dependency.instance(IEventsCache)
    quest = eventsCache.getHiddenQuests().get(EMAIL_CONFIRMATION_QUEST_ID)
    if quest is not None:
        return quest.getBonuses()
    else:
        return []


def fillRewards(model, bonuses=None, tooltipItems=None):
    bonuses = bonuses or getBonuses()
    bonuses.sort(key=_keyBonusesOrder)
    bonusesListModel = model.getBonuses()
    bonusesListModel.clear()
    packBonusModelAndTooltipData(bonuses=bonuses, packer=getDefaultBonusPacker(), model=bonusesListModel, tooltipData=tooltipItems)
    bonusesListModel.invalidate()