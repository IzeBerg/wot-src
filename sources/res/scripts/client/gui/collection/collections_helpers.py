import typing
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from shared_utils import findFirst, first
import nations
from CurrentVehicle import g_currentVehicle
from account_helpers import AccountSettings
from account_helpers.AccountSettings import COLLECTIONS_SECTION, COLLECTION_SHOWN_NEW_ITEMS, COLLECTION_SHOWN_NEW_ITEMS_COUNT, COLLECTION_SHOWN_NEW_REWARDS, COLLECTION_TUTORIAL_COMPLETED
from collections_common import CollectionItem, UNUSABLE_COLLECTION_ENTITIES
from gui.collection.collections_constants import COLLECTION_ITEM_RES_KEY_TEMPLATE, COLLECTION_RES_PREFIX
from gui.impl import backport
from gui.impl.gen import R
from gui.server_events.bonuses import getNonQuestBonuses, mergeBonuses, splitBonuses
from gui.shared.event_dispatcher import showHangar, showStylePreview, showStyleProgressionPreview
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import dependency
from helpers.dependency import replace_none_kwargs
from items.tankmen import getNationConfig, getNationGroups
from skeletons.gui.game_control import ICollectionsSystemController
from skeletons.gui.shared import IItemsCache
if typing.TYPE_CHECKING:
    from typing import List, Dict, Tuple, Union
    from gui.impl.gen_utils import DynAccessor

@replace_none_kwargs(itemsCache=IItemsCache)
def showCollectionStylePreview(styleCD, backCallback=None, backBtnDescrLabel='', itemsCache=None):
    style = itemsCache.items.getItemByCD(styleCD)
    vehicle = getVehicleForCollectionStyle(style)
    (showStyleProgressionPreview if style.isProgression else showStylePreview)(vehicle.intCD, style, style.getDescription(), backCallback or showHangar, backBtnDescrLabel)


@replace_none_kwargs(itemsCache=IItemsCache)
def getVehicleForCollectionStyle(style, itemsCache=None):

    def mayInstall(veh):
        return not veh.descriptor.type.isCustomizationLocked and style.mayInstall(veh)

    vehicle = g_currentVehicle.item if g_currentVehicle.isPresent() else None
    if vehicle is not None and mayInstall(vehicle):
        return vehicle
    else:
        suitableVehicles = (v for v in itemsCache.items.getVehicles(criteria=REQ_CRITERIA.VEHICLE.FOR_ITEM(style)).itervalues() if mayInstall(v))
        isInInventory, isNotSecret = (None, None)
        for v in sorted(suitableVehicles, key=lambda item: item.level, reverse=True):
            if isInInventory is None and v.isInInventory:
                isInInventory = v
                break
            if isNotSecret is None and not v.isSecret:
                isNotSecret = v

        return isInInventory or isNotSecret


@replace_none_kwargs(collections=ICollectionsSystemController)
def getItemInfo(itemId, collectionId, collections=None):
    item = collections.getCollectionItem(collectionId, itemId)
    name = getItemName(collectionId, item, collectionsSystem=collections)
    itemResKey = getItemResKey(collectionId, item)
    collectionRes = getCollectionRes(collectionId, collectionsSystem=collections)
    descriptionRes = collectionRes.item.description.dyn(itemResKey)
    description = backport.text(descriptionRes()) if descriptionRes.exists() else ''
    itemType = item.type
    if itemType in UNUSABLE_COLLECTION_ENTITIES:
        largeImage = backport.image(R.images.gui.maps.icons.collectionItems.c_1000x680.dyn(itemResKey)())
        smallImage = backport.image(R.images.gui.maps.icons.collectionItems.c_600x450.dyn(itemResKey)())
    else:
        largeImage = backport.image(R.images.gui.maps.icons.collectionItems.c_600x450.dyn(itemResKey)())
        smallImage = backport.image(R.images.gui.maps.icons.collectionItems.c_400x300.dyn(itemResKey)())
    return (name, itemType, description, largeImage, smallImage)


def getImagePath(imageResource):
    if imageResource.exists():
        return backport.image(imageResource())
    return ''


def getItemResKey(collectionId, item):
    return COLLECTION_ITEM_RES_KEY_TEMPLATE.format(item.type, collectionId, item.itemId)


@replace_none_kwargs(collectionsSystem=ICollectionsSystemController)
def getCollectionRes(collectionId, collectionsSystem=None):
    collectionName = collectionsSystem.getCollection(collectionId).name
    return R.strings.dyn(COLLECTION_RES_PREFIX + collectionName)


@replace_none_kwargs(collectionsSystem=ICollectionsSystemController)
def getItemName(collectionId, item, collectionsSystem=None):
    if item.type in UNUSABLE_COLLECTION_ENTITIES:
        return getUnusableItemName(collectionId, item, collectionsSystem=collectionsSystem)
    return getUsableItemName(item)


def getUsableItemName(item):
    if item.type == 'customizationItem':
        return getCustomizationName(item.relatedId)
    if item.type == 'dossier':
        return getDossierName(item.relatedId)
    if item.type == 'tankman':
        return getTankmanFullName(item.relatedId)
    return ''


@replace_none_kwargs(collectionsSystem=ICollectionsSystemController)
def getUnusableItemName(collectionId, item, collectionsSystem=None):
    itemTextRes = getCollectionRes(collectionId, collectionsSystem=collectionsSystem).item
    return backport.text(itemTextRes.name.dyn(getItemResKey(collectionId, item))())


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getCustomizationName(itemCD, itemsCache=None):
    customizationItem = itemsCache.items.getItemByCD(itemCD)
    textRes = R.strings.tooltips.vehiclePreview.boxTooltip.dyn(customizationItem.itemTypeName)
    return backport.text(textRes.header(), value=customizationItem.userName)


def getDossierName(itemName):
    _, recordName = itemName
    recordRes = backport.text(R.strings.achievements.dyn(recordName)())
    return backport.text(R.strings.collections.tooltips.item.achievement(), name=recordRes)


def getTankmanFullName(groupName):
    for nationId in nations.MAP.iterkeys():
        group = findFirst(lambda nationGroup: nationGroup.name == groupName, getNationGroups(nationId, True).values() + getNationGroups(nationId, False).values())
        if group is not None:
            firstNameId, lastNameId = first(group.firstNamesList), first(group.lastNamesList)
            nationConfig = getNationConfig(nationId)
            firstName, lastName = nationConfig.getFirstName(firstNameId), nationConfig.getLastName(lastNameId)
            return ('{} {}').format(firstName, lastName)

    return ''


def composeBonuses(bonuses):
    composedBonuses = []
    for bonus in bonuses:
        for key, value in bonus.iteritems():
            composedBonuses.extend(getNonQuestBonuses(key, value, ctx=None))

    mergedBonuses = mergeBonuses(composedBonuses)
    return splitBonuses(mergedBonuses)


def isRewardNew(collectionId, requiredCount):
    return not existsInCollectionsSection(COLLECTION_SHOWN_NEW_REWARDS, collectionId, requiredCount)


def setRewardShown(collectionId, requiredCount):
    addIntoCollectionsSection(COLLECTION_SHOWN_NEW_REWARDS, collectionId, requiredCount)


def isItemNew(collectionId, itemId):
    return not existsInCollectionsSection(COLLECTION_SHOWN_NEW_ITEMS, collectionId, itemId)


def setItemShown(collectionId, itemId):
    addIntoCollectionsSection(COLLECTION_SHOWN_NEW_ITEMS, collectionId, itemId)
    g_eventBus.handleEvent(events.CollectionsEvent(events.CollectionsEvent.NEW_ITEM_SHOWN), scope=EVENT_BUS_SCOPE.LOBBY)


def existsInCollectionsSection(settingName, collectionId, itemId):
    settings = AccountSettings.getUIFlag(COLLECTIONS_SECTION)
    settings[settingName].setdefault(collectionId, set())
    return itemId in settings[settingName][collectionId]


def addIntoCollectionsSection(settingName, collectionId, itemId):
    settings = AccountSettings.getUIFlag(COLLECTIONS_SECTION)
    settings[settingName].setdefault(collectionId, set())
    settings[settingName][collectionId].add(itemId)
    AccountSettings.setUIFlag(COLLECTIONS_SECTION, settings)


def getShownNewItemsCount(collectionId):
    settings = AccountSettings.getUIFlag(COLLECTIONS_SECTION)
    settings[COLLECTION_SHOWN_NEW_ITEMS_COUNT].setdefault(collectionId, 0)
    return settings[COLLECTION_SHOWN_NEW_ITEMS_COUNT][collectionId]


def setShownNewItemsCount(collectionId, itemCount):
    settings = AccountSettings.getUIFlag(COLLECTIONS_SECTION)
    settings[COLLECTION_SHOWN_NEW_ITEMS_COUNT][collectionId] = itemCount
    AccountSettings.setUIFlag(COLLECTIONS_SECTION, settings)


def isTutorialCompleted(collectionId):
    settings = AccountSettings.getUIFlag(COLLECTIONS_SECTION)
    return collectionId in settings[COLLECTION_TUTORIAL_COMPLETED]


def setCollectionTutorialCompleted(collectionId):
    settings = AccountSettings.getUIFlag(COLLECTIONS_SECTION)
    settings[COLLECTION_TUTORIAL_COMPLETED].add(collectionId)
    AccountSettings.setUIFlag(COLLECTIONS_SECTION, settings)