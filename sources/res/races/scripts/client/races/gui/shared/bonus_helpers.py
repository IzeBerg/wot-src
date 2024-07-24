import copy
from enum import IntEnum
import constants
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.bonuses_sorter import getBonusesSortKeyFunc, BonusesSortWeights, tokensBonusKeyFunc
from gui.server_events.bonuses import getMergeBonusFunction, LootBoxKeyTokensBonus, __mergeDicts
from shared_utils import first

class RacesBonusesSortWeights(IntEnum):
    TANKMAN = 19
    MEDAL = 20


def __racesTokensBonusKeyFunc(bonus):
    tokenId = first(bonus.getTokens().iterkeys())
    if tokenId.startswith(constants.LOOTBOX_KEY_PREFIX):
        return (-BonusesSortWeights.LOOTBOX, 0)
    return tokensBonusKeyFunc(bonus)


def __customizationBonusKeyFunc(bonus):
    item = bonus.getC11nItem(first(bonus.getCustomizations()))
    if item.itemTypeID == GUI_ITEM_TYPE.STYLE:
        return (-BonusesSortWeights.STYLE, 0)
    return (-BonusesSortWeights.UNSORTABLE, 0)


__RACES_BONUSES_KEYS_FUNC = {'dossier': lambda b: (
             -RacesBonusesSortWeights.MEDAL, 0), 
   'tmanToken': lambda b: (
               -RacesBonusesSortWeights.TANKMAN, 0), 
   'battleToken': __racesTokensBonusKeyFunc, 
   'customizations': __customizationBonusKeyFunc}

def sortBonuses(bonuses):
    bonuses = sorted(bonuses, key=getBonusesSortKeyFunc(__RACES_BONUSES_KEYS_FUNC))
    return bonuses


def getMergeRacesBonusFunction(lhv, rhv):

    def hasOneBaseClass(l, r, cls):
        return isinstance(l, cls) and isinstance(r, cls)

    def ofSameClassWithBase(l, r, cls):
        return hasOneBaseClass(l, r, cls) and type(l) is type(r)

    if ofSameClassWithBase(lhv, rhv, LootBoxKeyTokensBonus):
        return mergeLootboxKeyBonuses
    return getMergeBonusFunction(lhv, rhv)


def mergeLootboxKeyBonuses(lhv, rhv):
    merged = copy.deepcopy(lhv)
    mergedValue = merged.getValue()
    needPop = False
    if first(merged.getValue().keys()) == first(rhv.getValue().keys()):
        merged.setValue(__mergeDicts(mergedValue, rhv.getValue()))
        needPop = True
    return (merged, needPop)