import typing
from enum import Enum
from gui import GUI_NATIONS_ORDER_INDEX
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl import backport
from gui.impl.backport import createTooltipData, TooltipData, getNiceNumberFormat
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.battle_pass.crew_book_reward_option_model import CrewBookRewardOptionModel
from gui.impl.gen.view_models.views.lobby.battle_pass.device_reward_option_model import DeviceRewardOptionModel
from gui.impl.gen.view_models.views.lobby.battle_pass.kpi_description_model import KpiDescriptionModel
from gui.impl.gen.view_models.views.lobby.battle_pass.reward_option_model import RewardOptionModel
from gui.server_events.awards_formatters import ItemsBonusFormatter
from gui.shared.gui_items import KPI
from shared_utils import first
if typing.TYPE_CHECKING:
    from account_helpers.offers.offer_bonuses import CrewBooksOfferBonus, OfferBonusAdapter, ItemsOfferBonus

class BattlePassRewardOptionType(Enum):
    BLUEPRINT = 'blueprint'
    CREW_BROCHURE = 'brochure'
    CREW_GUIDE = 'guide'
    NEW_DEVICE_MI = 'newDeviceMI'
    NEW_DEVICE_FV = 'newDeviceFV'
    TROPHY_DEVICE = 'trophyDevice'


def _getPacker():
    deviceRewardOptionPacker = DeviceRewardOptionPacker()
    crewBookRewardOptionPacker = CrewBookRewardOptionPacker()
    return {BattlePassRewardOptionType.BLUEPRINT: NationalBlueprintRewardOptionPacker(), 
       BattlePassRewardOptionType.CREW_BROCHURE: crewBookRewardOptionPacker, 
       BattlePassRewardOptionType.CREW_GUIDE: crewBookRewardOptionPacker, 
       BattlePassRewardOptionType.NEW_DEVICE_MI: deviceRewardOptionPacker, 
       BattlePassRewardOptionType.NEW_DEVICE_FV: deviceRewardOptionPacker, 
       BattlePassRewardOptionType.TROPHY_DEVICE: deviceRewardOptionPacker}


class RewardOptionPacker(object):

    @classmethod
    def pack(cls, bonus):
        return cls._pack(bonus)

    @classmethod
    def getTooltip(cls, bonus):
        return cls._getTooltip(bonus)

    @classmethod
    def sort(cls, gifts):
        return cls._sort(gifts)

    @classmethod
    def _pack(cls, bonus):
        return RewardOptionModel()

    @classmethod
    def _getTooltip(cls, bonus):
        return createTooltipData(bonus.getTooltip())

    @classmethod
    def _sort(cls, gifts):
        return [ (giftId, bonus) for giftId, bonus in gifts.iteritems() ]


class DeviceRewardOptionPacker(RewardOptionPacker):

    @classmethod
    def _pack(cls, bonus):
        model = DeviceRewardOptionModel()
        item = bonus.displayedItem
        model.setName(item.userName)
        model.setIconName(item.name if item.isTrophy else item.getGUIEmblemID())
        model.setCount(bonus.getGiftCount())
        groupName = R.strings.artefacts.dyn(item.descriptor.groupName)
        effect = first(groupName.dyn('effect').values(), R.invalid)
        model.setEffect(backport.text(effect()) if effect.exists() else '')
        for kpi in item.getKpi():
            kpiModel = KpiDescriptionModel()
            value = cls.__packKpiValue(kpi)
            kpiModel.setValue(value)
            kpiModel.setDescription(backport.text(kpi.getDescriptionR()))
            kpiModel.setName(kpi.name)
            model.kpiDescriptions.addViewModel(kpiModel)

        return model

    @classmethod
    def _getTooltip(cls, bonus):
        return TooltipData(tooltip=None, isSpecial=True, specialAlias=ItemsBonusFormatter.getTooltip(bonus.displayedItem), specialArgs=[
         bonus.displayedItem.intCD])

    @staticmethod
    def __packKpiValue(kpi):
        if kpi.type == KPI.Type.AGGREGATE_MUL:
            value = (
             (kpi.value[0] - 1.0) * 100, (kpi.value[1] - 1.0) * 100)
            valueStr = ('{}-{}').format(getNiceNumberFormat(value[0]), getNiceNumberFormat(value[1]))
            valueStr = '+' + valueStr if value[0] > 0 else valueStr
        else:
            value = (kpi.value - 1.0) * 100 if kpi.type == KPI.Type.MUL else kpi.value
            valueStr = '+' + getNiceNumberFormat(value) if value > 0 else getNiceNumberFormat(value)
        return valueStr


class CrewBookRewardOptionPacker(RewardOptionPacker):

    @classmethod
    def _pack(cls, bonus):
        model = CrewBookRewardOptionModel()
        item = bonus.displayedItem
        model.setName(backport.text(R.strings.nations.dyn(item.getNation())()))
        model.setIconName(item.getBonusIconName())
        model.setCount(bonus.getGiftCount())
        model.setExpBonusValue(item.getXP())
        model.setDescription(backport.text(R.strings.battle_pass.rewardChoice.crewBook.rewardDescription(), nation=backport.text(R.strings.nations.dyn(item.getNation()).genetiveCase())))
        return model

    @classmethod
    def _getTooltip(cls, bonus):
        return TooltipData(tooltip=None, isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.CREW_BOOK, specialArgs=[
         bonus.displayedItem.intCD, bonus.getGiftCount()])

    @classmethod
    def _sort(cls, gifts):
        return sorted(gifts.items(), key=lambda gift: GUI_NATIONS_ORDER_INDEX[gift[1].displayedItem.getNation()])


class NationalBlueprintRewardOptionPacker(RewardOptionPacker):

    @classmethod
    def _pack(cls, bonus):
        model = RewardOptionModel()
        model.setName(backport.text(R.strings.nations.dyn(bonus.getImageCategory())()))
        model.setIconName(('blueprint_{}').format(bonus.getImageCategory()))
        model.setCount(bonus.getCount())
        model.setDescription(backport.text(R.strings.tooltips.blueprint.BlueprintFragmentTooltip.nationalDescription(), nation=backport.text(R.strings.nations.dyn(bonus.getImageCategory()).genetiveCase())))
        return model

    @classmethod
    def _getTooltip(cls, bonus):
        return TooltipData(tooltip=None, isSpecial=True, specialAlias=bonus.getBlueprintSpecialAlias(), specialArgs=[
         bonus.getBlueprintSpecialArgs()])

    @classmethod
    def _sort(cls, gifts):
        return sorted(gifts.items(), key=lambda gift: GUI_NATIONS_ORDER_INDEX[gift[1].getImageCategory()])


def packRewardOptionModel(rewardType, gifts, rewardsModel, tooltips):
    packer = _getPacker().get(rewardType)
    if packer is not None:
        for giftId, bonus in packer.sort(gifts):
            model = packer.pack(bonus)
            model.setGiftId(giftId)
            tooltip = packer.getTooltip(bonus)
            tooltips.update({str(giftId): tooltip})
            model.setTooltipId(str(giftId))
            rewardsModel.addViewModel(model)

    return