from constants import PREMIUM_ENTITLEMENTS
from gui.impl import backport
from gui.impl.gen import R
from gui.Scaleform.daapi.view.lobby.missions.awards_formatters import CurtailingAwardsComposer
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.impl.gen_utils import INVALID_RES_ID
from gui.server_events.awards_formatters import AWARDS_SIZES, PreformattedBonus, AwardsPacker, getDefaultFormattersMap, ItemsBonusFormatter, SimpleBonusFormatter, PremiumDaysBonusFormatter, formatCountLabel, VehiclesBonusFormatter, TokenBonusFormatter, DossierBonusFormatter, PostProcessTags, GoodiesBonusFormatter, CustomizationsBonusFormatter, BattlePassBonusFormatter
from gui.shared.gui_items.customization.c11n_items import ProjectionDecal, Style
from gui.shared.money import Currency
from halloween_common.halloween_constants import ArtefactsSettings
from gui.shared.missions.packers.bonus import DOSSIER_ACHIEVEMENT_POSTFIX, DOSSIER_BADGE_POSTFIX
_IMAGE_FORMAT = '.png'

def getImgName(path):
    if path is None:
        return ''
    else:
        return path.split('/')[(-1)].replace(_IMAGE_FORMAT, '').replace('-', '_')


class HWItemsBonusFormatter(ItemsBonusFormatter):

    def _formatBonusLabel(self, count):
        return formatCountLabel(count)


class HWCreditsBonusFormatter(SimpleBonusFormatter):

    @classmethod
    def _getLabel(cls, bonus):
        return str(bonus.getValue())


class HWMetaPremiumDaysBonusFormatter(PremiumDaysBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(bonus), images=self._getImages(bonus), tooltip=bonus.getTooltip(), isCompensation=self._isCompensation(bonus), label='')]


class HWVehiclesBonusFormatter(VehiclesBonusFormatter):

    @classmethod
    def _getLabel(cls, vehicle):
        return vehicle.userName


class HWVehiclesAwardsBonusFormatter(VehiclesBonusFormatter):

    @classmethod
    def _getImages(cls, vehicle, isRent=False):
        result = {AWARDS_SIZES.SMALL: vehicle.iconSmall, 
           AWARDS_SIZES.BIG: vehicle.icon}
        return result

    @classmethod
    def _getLabel(cls, vehicle):
        return vehicle.userName


class HWTokenBonusFormatter(TokenBonusFormatter):
    _KEY_ICON = backport.image(R.images.halloween.gui.maps.icons.key.keys())

    def _getFormattedBonus(self, tokenID, token, bonus):
        formatted = super(HWTokenBonusFormatter, self)._getFormattedBonus(tokenID, token, bonus)
        if tokenID == ArtefactsSettings.CREW_100:
            return self._crewFormattedBonus(tokenID)
        if tokenID == ArtefactsSettings.KEY_TOKEN:
            bonuseValue = bonus.getValue()
            return PreformattedBonus(bonusName=tokenID.replace(':', '_'), images={AWARDS_SIZES.SMALL: '', 
               AWARDS_SIZES.BIG: self._KEY_ICON}, label=bonuseValue.get(tokenID, {}).get('count'), userName=backport.text(R.strings.halloween_lobby.bundleView.reward.hw23_artefact_key()), tooltip=R.views.halloween.lobby.tooltips.KeyTooltip())
        return formatted

    def _formatComplexToken(self, complexToken, token, bonus):
        if complexToken.styleID == ArtefactsSettings.ARTEFACT:
            return PreformattedBonus(bonusName=complexToken.styleID, images={AWARDS_SIZES.SMALL: '', 
               AWARDS_SIZES.BIG: ''}, label='')
        return super(HWTokenBonusFormatter, self)._formatComplexToken(complexToken, token, bonus)

    def _crewFormattedBonus(self, tokenID):
        return PreformattedBonus(bonusName=tokenID.replace(':', '_'), images={AWARDS_SIZES.SMALL: '', 
           AWARDS_SIZES.BIG: ''}, label='')


class HWBattleResultBonusFormatter(HWTokenBonusFormatter):
    _KEY_ICON = backport.image(R.images.halloween.gui.maps.icons.key.key_80x80())


class HWDossierBonusFormatter(DossierBonusFormatter):

    def _format(self, bonus):
        result = []
        for achievement in bonus.getAchievements():
            result.append(PreformattedBonus(label=self._getUserName(achievement), bonusName=bonus.getName() + DOSSIER_ACHIEVEMENT_POSTFIX, userName=self._getUserName(achievement), images=self._getImages(achievement), isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BATTLE_STATS_ACHIEVS, specialArgs=[
             achievement.getBlock(), achievement.getName(), achievement.getValue()], isCompensation=self._isCompensation(bonus)))

        for badge in bonus.getBadges():
            result.append(PreformattedBonus(label=self._getUserName(badge), bonusName=bonus.getName() + DOSSIER_BADGE_POSTFIX, userName=self._getUserName(badge), images=self._getBadgeImages(badge), isSpecial=True, specialAlias=self._getBadgeTooltipAlias(), specialArgs=[
             badge.badgeID], isCompensation=self._isCompensation(bonus), postProcessTags=(
             PostProcessTags.getBadgeTag(badge),)))

        return result


class HWAwardsCustomizationsBonusFormatter(CustomizationsBonusFormatter):

    @classmethod
    def _getUserName(cls, c11nItem):
        if isinstance(c11nItem, Style):
            return backport.text(R.strings.halloween_lobby.rewardWindow.description.rewardType.style(), userName=c11nItem.userName)
        if isinstance(c11nItem, ProjectionDecal):
            return backport.text(R.strings.halloween_lobby.rewardWindow.description.rewardType.projection_decal(), userName=c11nItem.userName)
        return super(HWAwardsCustomizationsBonusFormatter, cls)._getUserName(c11nItem)


class HWGoodiesBonusFormatter(GoodiesBonusFormatter):

    @classmethod
    def _getImagesRecertificationForm(cls, form):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, form.itemTypeName)

        return result

    @classmethod
    def _getDemountKitImages(cls, demountKit):
        result = {}
        for size in AWARDS_SIZES.ALL():
            result[size] = RES_ICONS.getBonusIcon(size, demountKit.demountKitGuiType)

        return result


class HWBundleGoodiesBonusFormatter(GoodiesBonusFormatter):

    def _formatBonusLabel(self, count):
        return count

    @classmethod
    def _getImages(cls, booster):
        resId = R.images.gui.maps.icons.quests.bonuses.s180x135.dyn(booster.getFullNameForResource())()
        if resId != INVALID_RES_ID:
            return {AWARDS_SIZES.SMALL: '', 
               AWARDS_SIZES.BIG: backport.image(resId)}
        return {}

    @classmethod
    def _getUserName(cls, booster):
        resId = R.strings.halloween_lobby.bundleView.reward.dyn(booster.boosterGuiType)()
        if resId != INVALID_RES_ID:
            return backport.text(resId)
        return booster.userName


class HWBundlePremiumDaysBonusFormatter(PremiumDaysBonusFormatter):

    def _format(self, bonus):
        return [
         PreformattedBonus(bonusName=bonus.getName(), userName=self._getUserName(bonus), images=self._getImages(bonus), tooltip=bonus.getTooltip(), isCompensation=self._isCompensation(bonus), label=bonus.getValue())]

    @classmethod
    def _getImages(cls, bonus):
        imgName = ('premium_plus_{}').format(bonus.getValue())
        resId = R.images.gui.maps.icons.quests.bonuses.s180x135.dyn(imgName)()
        if resId != INVALID_RES_ID:
            return {AWARDS_SIZES.SMALL: '', 
               AWARDS_SIZES.BIG: backport.image(resId)}
        return {AWARDS_SIZES.SMALL: '', 
           AWARDS_SIZES.BIG: backport.image(R.images.gui.maps.shop.premium.c_180x135.premium_icon_wot())}


class HWBundleCustomizationsBonusFormatter(HWAwardsCustomizationsBonusFormatter):

    @classmethod
    def _getImages(cls, c11nItem):
        img = R.images.gui.maps.icons.quests.bonuses.s180x135.dyn(getImgName(c11nItem.icon))()
        if img != -1:
            return {AWARDS_SIZES.BIG: backport.image(img)}
        iconName = c11nItem.itemTypeName
        if iconName == 'style' and c11nItem.modelsSet:
            iconName = 'style_3d'
        defImg = R.images.gui.maps.icons.quests.bonuses.s180x135.dyn(iconName)()
        if defImg != -1:
            return {AWARDS_SIZES.BIG: backport.image(defImg)}
        return {}

    def _formatBonusLabel(self, count):
        return count


class HWBattlePassBonusFormatter(BattlePassBonusFormatter):

    @classmethod
    def _getLabel(cls, bonus):
        return bonus.getCount()


def getHWMetaFormattersMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'items': HWItemsBonusFormatter(), 
       Currency.CREDITS: HWCreditsBonusFormatter(), 
       'vehicles': HWVehiclesBonusFormatter(), 
       'battleToken': HWTokenBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.BASIC: HWMetaPremiumDaysBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.PLUS: HWMetaPremiumDaysBonusFormatter(), 
       'dossier': HWDossierBonusFormatter(), 
       'goodies': HWGoodiesBonusFormatter(), 
       'battlePassPoints': HWBattlePassBonusFormatter()})
    return mapping


def getHWBundleFormattersMap():
    mapping = getDefaultFormattersMap()
    mapping.update({'battleToken': HWTokenBonusFormatter(), 
       'goodies': HWBundleGoodiesBonusFormatter(), 
       PREMIUM_ENTITLEMENTS.PLUS: HWBundlePremiumDaysBonusFormatter(), 
       'customizations': HWBundleCustomizationsBonusFormatter()})
    return mapping


def getAwardsHWMetaFormattersMap():
    mapping = getHWMetaFormattersMap()
    mapping.update({'vehicles': HWVehiclesAwardsBonusFormatter(), 
       'customizations': HWAwardsCustomizationsBonusFormatter()})
    return mapping


def getHWBattleResultFormattersMap():
    mapping = getHWMetaFormattersMap()
    mapping.update({'battleToken': HWBattleResultBonusFormatter()})
    return mapping


def getHWMetaAwardFormatter(isAwardsScreen=False):
    if isAwardsScreen:
        return AwardsPacker(getAwardsHWMetaFormattersMap())
    return AwardsPacker(getHWMetaFormattersMap())


def getHWBundleAwardFormatter():
    return AwardsPacker(getHWBundleFormattersMap())


def getHWBattleResultAwardFormatter():
    return AwardsPacker(getHWBattleResultFormattersMap())


class HalloweenBonusesAwardsComposer(CurtailingAwardsComposer):

    def _packBonus(self, bonus, size=AWARDS_SIZES.SMALL):
        return bonus

    def _packMergedBonuses(self, mergedBonuses, size=AWARDS_SIZES.SMALL):
        mergedBonusCount = len(mergedBonuses)
        imgs = {AWARDS_SIZES.SMALL: RES_ICONS.getBonusIcon(AWARDS_SIZES.SMALL, 'default'), 
           AWARDS_SIZES.BIG: RES_ICONS.getBonusIcon(AWARDS_SIZES.BIG, 'default')}
        return PreformattedBonus(bonusName='default', label=backport.text(R.strings.halloween_lobby.reward.rest(), count=mergedBonusCount), images=imgs, isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.ADDITIONAL_AWARDS, specialArgs=self._getShortBonusesData(mergedBonuses, size), userName='')