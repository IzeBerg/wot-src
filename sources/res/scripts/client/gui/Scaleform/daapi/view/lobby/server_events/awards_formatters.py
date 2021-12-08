import typing
from gui.battle_pass.battle_pass_helpers import getStyleForChapter
from gui.gift_system.constants import NY_STAMP_CODE
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.auxiliary.rewards_helper import NEW_STYLE_FORMATTED_BONUSES
from gui.server_events import formatters
from gui.server_events.awards_formatters import AWARDS_SIZES, AwardsPacker, QuestsBonusComposer, getPostBattleAwardsPacker
from gui.server_events.bonuses import BlueprintsBonusSubtypes, LootBoxTokensBonus
from gui.battle_pass.battle_pass_bonuses_helper import BonusesHelper
from gui.Scaleform.daapi.view.lobby.missions.awards_formatters import NewStyleBonusComposer
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.shared.formatters import text_styles
from gui.shared.formatters.icons import makeImageTag
from gui.shared.gui_items.crew_skin import localizedFullName as localizeSkinName
from gui.shared.utils.functions import makeTooltip
from helpers import dependency
from skeletons.gui.shared import IItemsCache
if typing.TYPE_CHECKING:
    from gui.server_events.bonuses import TokensBonus, EntitlementBonus
SIMPLE_BONUSES_MAX_ITEMS = 5
_DISPLAYED_AWARDS_COUNT = 2
_END_LINE_SEPARATOR = ','
_EMPTY_STRING = ''

class OldStyleBonusFormatter(object):

    def __init__(self):
        self._result = []

    def accumulateBonuses(self, bonus):
        self._result.append(bonus)

    def extractFormattedBonuses(self, addLineSeparator=False):
        result = self._result[:]
        self._result = []
        return result

    @classmethod
    def getOrder(cls):
        return 0


class DossierFormatter(OldStyleBonusFormatter):

    @classmethod
    def getOrder(cls):
        return 1

    def accumulateBonuses(self, bonus):
        for achieve in bonus.getAchievements():
            self._result.append(formatters.packAchieveElementByItem(achieve))

        for badge in bonus.getBadges():
            self._result.append(formatters.packBadgeElementByItem(badge))


class CustomizationsFormatter(OldStyleBonusFormatter):

    @classmethod
    def getOrder(cls):
        return 2

    def accumulateBonuses(self, bonus):
        customizationsList = bonus.getList()
        if customizationsList:
            self._result.append(formatters.packCustomizations(customizationsList))


class VehiclesFormatter(OldStyleBonusFormatter):

    def __init__(self, event):
        super(VehiclesFormatter, self).__init__()
        self.__eventID = str(event.getID())

    @classmethod
    def getOrder(cls):
        return 3

    def accumulateBonuses(self, bonus, event=None):
        formattedList = bonus.formattedList()
        if formattedList:
            vehiclesLbl, _ = _joinUpToMax(formattedList)
            self._result.append(formatters.packVehiclesBonusBlock(vehiclesLbl, self.__eventID))


class CrewBookFormatter(OldStyleBonusFormatter):

    @classmethod
    def getOrder(cls):
        return 4

    def accumulateBonuses(self, bonus):
        result = []
        for book, count in sorted(bonus.getItems()):
            if book is None or not count:
                continue
            result.append(self._formatBook(book, count))

        if result:
            self._result.append(formatters.packSimpleBonusesBlock(result))
        return

    @classmethod
    def _formatBook(cls, book, count):
        return backport.text(R.strings.quests.bonuses.items.name(), name=book.userName, count=count)


class CrewSkinFormatter(OldStyleBonusFormatter):

    @classmethod
    def getOrder(cls):
        return 5

    def accumulateBonuses(self, bonus):
        result = []
        for skin, count, _, _ in sorted(bonus.getItems()):
            if skin is None or not count:
                continue
            result.append(self._formatCrewSkin(skin, count))

        if result:
            self._result.append(formatters.packSimpleBonusesBlock(result))
        return

    @classmethod
    def _formatCrewSkin(cls, skin, count):
        return backport.text(R.strings.quests.bonuses.items.name(), name=localizeSkinName(skin), count=count)


class BlueprintsFormatter(OldStyleBonusFormatter):

    @classmethod
    def getOrder(cls):
        return 5

    def accumulateBonuses(self, bonus):
        result = [
         self._formatBlueprint(bonus, bonus.getCount())]
        if result:
            self._result.append(formatters.packSimpleBonusesBlock(result))

    @classmethod
    def _formatBlueprint(cls, bonus, count):
        blueprintType = bonus.getBlueprintName()
        if blueprintType == BlueprintsBonusSubtypes.FINAL_FRAGMENT:
            blueprintString = backport.text(R.strings.quests.bonusName.blueprints.any())
        elif blueprintType == BlueprintsBonusSubtypes.UNIVERSAL_FRAGMENT:
            blueprintString = backport.text(R.strings.quests.bonusName.blueprints.universal())
        elif blueprintType == BlueprintsBonusSubtypes.NATION_FRAGMENT:
            blueprintString = backport.text(R.strings.quests.bonusName.blueprints.nation.any())
        elif blueprintType == BlueprintsBonusSubtypes.VEHICLE_FRAGMENT:
            blueprintString = backport.text(R.strings.quests.bonusName.blueprints.vehicle.any())
        elif blueprintType == BlueprintsBonusSubtypes.RANDOM_FRAGMENT:
            blueprintString = backport.text(R.strings.quests.bonusName.blueprints.any())
        elif blueprintType == BlueprintsBonusSubtypes.RANDOM_NATIONAL_FRAGMENT:
            blueprintString = backport.text(R.strings.quests.bonusName.blueprints.nation.any())
        return (' ').join([blueprintString, str(count)])


class BattlePassPointsFormatter(OldStyleBonusFormatter):

    def accumulateBonuses(self, bonus):
        formattedList = bonus.formattedList()
        if formattedList:
            self._result.append(formatters.packSimpleBonusesBlock(formattedList))


class SimpleBonusFormatter(OldStyleBonusFormatter):

    def accumulateBonuses(self, bonus, event=None):
        formattedList = bonus.formattedList()
        if formattedList:
            self._result.extend(formattedList)

    def extractFormattedBonuses(self, addLineSeparator=False):
        simpleBonusesList = super(SimpleBonusFormatter, self).extractFormattedBonuses()
        result = []
        if simpleBonusesList:
            result.append(formatters.packSimpleBonusesBlock(simpleBonusesList, endlineSymbol=_END_LINE_SEPARATOR if addLineSeparator else _EMPTY_STRING))
        return result


class LootBoxTokenFormatter(SimpleBonusFormatter):
    __itemsCache = dependency.descriptor(IItemsCache)

    def accumulateBonuses(self, bonus, event=None):
        for token in bonus.getTokens().itervalues():
            lootBox = self.__itemsCache.items.tokens.getLootBoxByTokenID(token.id)
            if lootBox is None:
                return
            boxType = lootBox.getType()
            iconName = ('lootBox_{0}').format(boxType)
            icon = makeImageTag(source=backport.image(R.images.gui.maps.icons.quests.bonuses.small.dyn(iconName)()), width=32, height=32, vSpace=-14)
            boxName = backport.text(R.strings.lootboxes.type.dyn(boxType)())
            boxCount = text_styles.stats(backport.text(R.strings.ny.postbattle.lootBox.boxCount(), count=token.count))
            label = text_styles.main(backport.text(R.strings.ny.postbattle.lootBox.boxesLabel(), boxName=boxName, icon=icon, boxCount=boxCount))
            tooltip = makeTooltip(header=lootBox.getUserName(), body=TOOLTIPS.QUESTS_BONUSES_LOOTBOXTOKEN_BODY)
            self._result.append(formatters.packSingleLineBonusesBlock([label], complexTooltip=tooltip))

        return

    def extractFormattedBonuses(self, addLineSeparator=False):
        result = []
        if self._result:
            result.extend(self._result)
        return result


class GiftStampsFormatter(OldStyleBonusFormatter):

    def accumulateBonuses(self, bonus, event=None):
        amount = bonus.getValue().amount
        iconRes = R.images.gui.maps.icons.quests.bonuses.small.giftSystem_2_nyStamp
        icon = makeImageTag(source=backport.image(iconRes()), width=32, height=32, vSpace=-14)
        stampsCount = text_styles.stats(backport.text(R.strings.ny.postbattle.giftSystem.stampsCount(), count=amount))
        label = backport.text(R.strings.ny.postbattle.giftSystem.stampsLabel(), icon=icon, stampsCount=stampsCount)
        tooltipData = bonus.getTooltipData()
        block = formatters.packSingleLineBonusesBlock([
         text_styles.main(label)], complexTooltip=tooltipData.tooltip, specialTooltip=tooltipData.specialAlias)
        self._result.append(block)


class TextBonusFormatter(OldStyleBonusFormatter):

    def accumulateBonuses(self, bonus, event=None):
        formattedList = BonusesHelper.getTextStrings(bonus)
        if formattedList:
            self._result.extend(formattedList)

    def extractFormattedBonuses(self, addLineSeparator=False):
        simpleBonusesList = super(TextBonusFormatter, self).extractFormattedBonuses()
        result = []
        if simpleBonusesList:
            result.append(formatters.packSimpleBonusesBlock(simpleBonusesList, endlineSymbol=_END_LINE_SEPARATOR if addLineSeparator else _EMPTY_STRING))
        return result


class BattlePassStyleProgressFormatter(OldStyleBonusFormatter):

    def accumulateBonuses(self, bonus, event=None):
        formattedList = BonusesHelper.getTextStrings(bonus)
        if formattedList:
            self._result.append(formatters.packSimpleBonusesBlock(formattedList, complexTooltip=self.__getTooltip(bonus)))

    def __getTooltip(self, bonus):
        chapter = bonus.getChapter()
        style = getStyleForChapter(chapter)
        tooltip = ''
        if style is None:
            body = backport.text(R.strings.battle_pass.styleProgressBonus.notChosen.tooltip())
            tooltip = makeTooltip(body=body)
        return tooltip


class NewStyleBonusFormatter(OldStyleBonusFormatter):

    def __init__(self, awardsPacker=None):
        super(NewStyleBonusFormatter, self).__init__()
        self.__formatter = NewStyleBonusComposer(_DISPLAYED_AWARDS_COUNT, awardsPacker or getPostBattleAwardsPacker())

    def accumulateBonuses(self, bonus, event=None):
        formattedBonuses = self.__formatter.getVisibleFormattedBonuses([], [bonus], 'big')
        if formattedBonuses:
            self._result.extend(formattedBonuses)

    def extractFormattedBonuses(self, addLineSeparator=False):
        simpleBonusesList = super(NewStyleBonusFormatter, self).extractFormattedBonuses()
        result = []
        if simpleBonusesList:
            result.append(formatters.packNewStyleBonusesBlock(simpleBonusesList, endlineSymbol=_END_LINE_SEPARATOR if addLineSeparator else _EMPTY_STRING))
        return result


def getFormattersMap(event):
    return {'dossier': DossierFormatter(), 
       'customizations': CustomizationsFormatter(), 
       'vehicles': VehiclesFormatter(event), 
       'crewBooks': CrewBookFormatter(), 
       'blueprints': BlueprintsFormatter(), 
       'crewSkins': CrewSkinFormatter(), 
       'battlePassPoints': BattlePassPointsFormatter()}


class OldStyleAwardsPacker(AwardsPacker):

    def __init__(self, event):
        super(OldStyleAwardsPacker, self).__init__(getFormattersMap(event))
        self.__defaultFormatter = SimpleBonusFormatter()
        self.__newStyleFormatter = NewStyleBonusFormatter()
        self.__lootBoxFormatter = LootBoxTokenFormatter()
        self.__giftStampsFormatter = GiftStampsFormatter()

    def format(self, bonuses, event=None):
        formattedBonuses = []
        isCustomizationBonusExist = False
        for b in bonuses:
            if b.isShowInGUI():
                if b.getName() == 'battleToken' and isinstance(b, LootBoxTokensBonus):
                    formatter = self.__lootBoxFormatter
                elif b.getName() == 'entitlements' and b.getValue().id == NY_STAMP_CODE:
                    formatter = self.__giftStampsFormatter
                else:
                    formatter = self._getBonusFormatter(b.getName())
                if formatter:
                    formatter.accumulateBonuses(b)
                if b.getName() == 'customizations':
                    isCustomizationBonusExist = True

        fmts = [
         self.__lootBoxFormatter, self.__giftStampsFormatter, self.__defaultFormatter, self.__newStyleFormatter]
        fmts.extend(sorted(self.getFormatters().itervalues(), key=lambda f: f.getOrder()))
        for formatter in fmts:
            formattedBonuses.extend(formatter.extractFormattedBonuses(isCustomizationBonusExist))

        return formattedBonuses

    def _getBonusFormatter(self, bonusName):
        if bonusName in NEW_STYLE_FORMATTED_BONUSES:
            return self.__newStyleFormatter
        return self.getFormatters().get(bonusName, self.__defaultFormatter)


def getTextFormattersMap():
    return {'default': TextBonusFormatter(), 
       'customizations': CustomizationsFormatter(), 
       'styleProgressToken': BattlePassStyleProgressFormatter()}


class BattlePassTextBonusesPacker(AwardsPacker):

    def __init__(self):
        super(BattlePassTextBonusesPacker, self).__init__(getTextFormattersMap())

    def format(self, bonuses, event=None):
        formattedBonuses = []
        for b in bonuses:
            if b.isShowInGUI():
                formatter = self._getBonusFormatter(b.getName())
                if formatter:
                    formatter.accumulateBonuses(b)

        for formatter in sorted(self.getFormatters().itervalues(), key=lambda f: f.getOrder()):
            formattedBonuses.extend(formatter.extractFormattedBonuses())

        return formattedBonuses

    def _getBonusFormatter(self, bonusName):
        formattersMap = self.getFormatters()
        if bonusName in formattersMap:
            return formattersMap[bonusName]
        else:
            return formattersMap.get('default', None)


class OldStyleBonusesFormatter(QuestsBonusComposer):

    def __init__(self, event):
        super(OldStyleBonusesFormatter, self).__init__(OldStyleAwardsPacker(event))

    def getFormattedBonuses(self, bonuses, size=AWARDS_SIZES.SMALL):
        return self.getPreformattedBonuses(bonuses)


def _joinUpToMax(array, separator=', '):
    if len(array) > SIMPLE_BONUSES_MAX_ITEMS:
        label = separator.join(array[:SIMPLE_BONUSES_MAX_ITEMS]) + '..'
        fullLabel = separator.join(array)
    else:
        label = separator.join(array)
        fullLabel = None
    return (
     label, fullLabel)