import logging
from typing import TYPE_CHECKING
from constants import PREMIUM_ENTITLEMENTS
from gui import GUI_NATIONS
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl import backport
from gui.impl.backport import TooltipData, createTooltipData
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.lootbox_system.bonus_model import BonusModel, BonusRarity, VehicleType
from gui.lootbox_system.awards_manager import AwardsManager
from gui.lootbox_system.common import LOOTBOX_RANDOM_NATIONAL_BLUEPRINT, LOOTBOX_RANDOM_NATIONAL_BROCHURE, LOOTBOX_RANDOM_NATIONAL_CREW_BOOK, LOOTBOX_RANDOM_NATIONAL_GUIDE
from gui.lootbox_system.utils import getSingleVehicleCDForCustomization
from gui.server_events.awards_formatters import BATTLE_BONUS_X5_TOKEN, CREW_BONUS_X3_TOKEN
from gui.server_events.bonuses import BlueprintsBonusSubtypes, LootBoxRandomNationalBonus, PlusPremiumDaysBonus, VehiclesBonus, _BONUSES
from gui.server_events.recruit_helper import getRecruitInfo
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.gui_items.Vehicle import getIconResourceName, getNationLessName, getUnicName
from gui.shared.gui_items.customization import CustomizationTooltipContext
from gui.shared.missions.packers.bonus import BACKPORT_TOOLTIP_CONTENT_ID, BaseBonusUIPacker, BlueprintBonusUIPacker, BonusUIPacker, CrewBookBonusUIPacker, CrewSkinBonusUIPacker, GoodiesBonusUIPacker, ItemBonusUIPacker, SimpleBonusUIPacker, TokenBonusUIPacker, VehiclesBonusUIPacker, getDefaultBonusPackersMap, getLocalizedBonusName
from gui.shared.money import Currency, Money
from gui.shared.utils.functions import makeTooltip
from helpers import dependency, int2roman
from items.components.crew_books_constants import CREW_BOOK_RARITY
from items.tankmen import RECRUIT_TMAN_TOKEN_PREFIX
from shared_utils import first
from skeletons.gui.shared import IItemsCache
if TYPE_CHECKING:
    from typing import Dict, List, Optional, Tuple, Union
    from frameworks.wulf import Array
    from gui.impl.wrappers.user_list_model import UserListModel
    from gui.server_events.bonuses import CustomizationsBonus, SimpleBonus, TokensBonus
    BonusModelsList = Union[(Array[BonusModel], UserListModel[BonusModel])]
_logger = logging.getLogger(__name__)
VEH_COMP_R_ID = R.views.lobby.awards.tooltips.RewardCompensationTooltip()

def getLootBoxesBonusPacker():
    mapping = getDefaultBonusPackersMap()
    simplePacker = LootBoxSimpleBonusUIPacker()
    blueprintPacker = LootBoxBlueprintBonusUIPacker()
    specialRandomPacker = LootBoxSpecialRandomBonusUIPacker()
    mapping.update({'battleToken': LootBoxTokenBonusUIPacker, 
       'blueprints': blueprintPacker, 
       'blueprintsAny': blueprintPacker, 
       'crewBooks': LootBoxCrewBookBonusUIPacker(), 
       'crewSkins': LootBoxCrewSkinBonusUIPacker(), 
       'customizations': LootBoxCustomizationsBonusUIPacker, 
       'finalBlueprints': blueprintPacker, 
       'goodies': LootBoxGoodiesBonusUIPacker(), 
       'items': LootBoxItemBonusUIPacker(), 
       'lootBox': LootBoxesLootBoxBonusUIPacker(), 
       'slots': LootBoxSlotsBonusUIPacker(), 
       'tmanToken': LootBoxTmanTemplateBonusUIPacker(), 
       'tokens': LootBoxTokenBonusUIPacker, 
       'vehicles': LootBoxVehiclesBonusUIPacker(), 
       Currency.FREE_XP: simplePacker, 
       Currency.CREDITS: simplePacker, 
       Currency.GOLD: simplePacker, 
       Currency.EQUIP_COIN: simplePacker, 
       Currency.CRYSTAL: simplePacker, 
       PREMIUM_ENTITLEMENTS.PLUS: LootBoxPremiumBonusUIPacker(), 
       LOOTBOX_RANDOM_NATIONAL_BLUEPRINT: specialRandomPacker, 
       LOOTBOX_RANDOM_NATIONAL_BROCHURE: specialRandomPacker, 
       LOOTBOX_RANDOM_NATIONAL_GUIDE: specialRandomPacker, 
       LOOTBOX_RANDOM_NATIONAL_CREW_BOOK: specialRandomPacker})
    return BonusUIPacker(mapping)


def packBonusModelAndTooltipData(bonuses, bonusModelsList, tooltipData=None, merge=False, packer=None):
    if packer is None:
        packer = getLootBoxesBonusPacker()
    bonusIndexTotal = 0
    if tooltipData is not None:
        bonusIndexTotal = len(tooltipData)
    bonusesList = bonuses
    if merge:
        bonusesList = mergeNeededBonuses(bonuses)
    bonusesCount = 0
    for bonus in bonusesList:
        if bonus.isShowInGUI():
            bonusList = packer.pack(bonus)
            bonusTooltipList = []
            bonusContentIdList = []
            if bonusList and tooltipData is not None:
                bonusTooltipList = packer.getToolTip(bonus)
                bonusContentIdList = packer.getContentId(bonus)
            for bonusIndex, item in enumerate(bonusList):
                item.setIndex(bonusIndex)
                bonusModelsList.addViewModel(item)
                bonusesCount += _getBonusCount(item)
                if tooltipData is not None:
                    tooltipIdx = str(bonusIndexTotal)
                    item.setTooltipId(tooltipIdx)
                    if bonusTooltipList:
                        tooltipData[tooltipIdx] = bonusTooltipList[bonusIndex]
                    if bonusContentIdList:
                        item.setTooltipContentId(str(bonusContentIdList[bonusIndex]))
                    bonusIndexTotal += 1

    return bonusesCount


def mergeNeededBonuses--- This code section failed: ---

 L. 130         0  BUILD_LIST_0          0 
                3  STORE_FAST            1  'finalBonuses'

 L. 131         6  LOAD_CONST               ('blueprints', 'brochure', 'guide', 'crewBook')
                9  STORE_FAST            2  'mergeBonusNames'

 L. 132        12  LOAD_DICTCOMP            '<code_object <dictcomp>>'
               15  MAKE_FUNCTION_0       0  None
               18  LOAD_FAST             2  'mergeBonusNames'
               21  GET_ITER         
               22  CALL_FUNCTION_1       1  None
               25  STORE_FAST            3  'bonusesForMerge'

 L. 133        28  LOAD_DICTCOMP            '<code_object <dictcomp>>'
               31  MAKE_FUNCTION_0       0  None
               34  LOAD_FAST             2  'mergeBonusNames'
               37  GET_ITER         
               38  CALL_FUNCTION_1       1  None
               41  STORE_FAST            4  'usedNations'

 L. 134        44  LOAD_DICTCOMP            '<code_object <dictcomp>>'
               47  MAKE_FUNCTION_0       0  None
               50  LOAD_FAST             2  'mergeBonusNames'
               53  GET_ITER         
               54  CALL_FUNCTION_1       1  None
               57  STORE_FAST            5  'value'

 L. 135        60  BUILD_MAP_4           4  None

 L. 136        63  LOAD_LAMBDA              '<code_object <lambda>>'
               66  MAKE_FUNCTION_0       0  None
               69  LOAD_CONST               'blueprints'
               72  STORE_MAP        

 L. 137        73  LOAD_LAMBDA              '<code_object <lambda>>'
               76  MAKE_FUNCTION_0       0  None
               79  LOAD_CONST               'brochure'
               82  STORE_MAP        

 L. 138        83  LOAD_LAMBDA              '<code_object <lambda>>'
               86  MAKE_FUNCTION_0       0  None
               89  LOAD_CONST               'guide'
               92  STORE_MAP        

 L. 139        93  LOAD_LAMBDA              '<code_object <lambda>>'
               96  MAKE_FUNCTION_0       0  None
               99  LOAD_CONST               'crewBook'
              102  STORE_MAP        
              103  STORE_FAST            6  'getValue'

 L. 141       106  BUILD_MAP_4           4  None

 L. 142       109  LOAD_LAMBDA              '<code_object <lambda>>'
              112  MAKE_FUNCTION_0       0  None
              115  LOAD_CONST               'blueprints'
              118  STORE_MAP        

 L. 143       119  LOAD_LAMBDA              '<code_object <lambda>>'
              122  MAKE_FUNCTION_0       0  None
              125  LOAD_CONST               'brochure'
              128  STORE_MAP        

 L. 144       129  LOAD_LAMBDA              '<code_object <lambda>>'
              132  MAKE_FUNCTION_0       0  None
              135  LOAD_CONST               'guide'
              138  STORE_MAP        

 L. 145       139  LOAD_LAMBDA              '<code_object <lambda>>'
              142  MAKE_FUNCTION_0       0  None
              145  LOAD_CONST               'crewBook'
              148  STORE_MAP        
              149  STORE_FAST            7  'getNation'

 L. 147       152  BUILD_MAP_4           4  None

 L. 148       155  LOAD_LAMBDA              '<code_object <lambda>>'
              158  MAKE_FUNCTION_0       0  None
              161  LOAD_CONST               'blueprints'
              164  STORE_MAP        

 L. 150       165  LOAD_LAMBDA              '<code_object <lambda>>'
              168  MAKE_FUNCTION_0       0  None
              171  LOAD_CONST               'brochure'
              174  STORE_MAP        

 L. 152       175  LOAD_LAMBDA              '<code_object <lambda>>'
              178  MAKE_FUNCTION_0       0  None
              181  LOAD_CONST               'guide'
              184  STORE_MAP        

 L. 154       185  LOAD_LAMBDA              '<code_object <lambda>>'
              188  MAKE_FUNCTION_0       0  None
              191  LOAD_CONST               'crewBook'
              194  STORE_MAP        
              195  STORE_FAST            8  'checkBonus'

 L. 157       198  BUILD_MAP_4           4  None

 L. 158       201  LOAD_GLOBAL           0  'LOOTBOX_RANDOM_NATIONAL_BLUEPRINT'
              204  LOAD_CONST               'blueprints'
              207  STORE_MAP        

 L. 159       208  LOAD_GLOBAL           1  'LOOTBOX_RANDOM_NATIONAL_BROCHURE'
              211  LOAD_CONST               'brochure'
              214  STORE_MAP        

 L. 160       215  LOAD_GLOBAL           2  'LOOTBOX_RANDOM_NATIONAL_GUIDE'
              218  LOAD_CONST               'guide'
              221  STORE_MAP        

 L. 161       222  LOAD_GLOBAL           3  'LOOTBOX_RANDOM_NATIONAL_CREW_BOOK'
              225  LOAD_CONST               'crewBook'
              228  STORE_MAP        
              229  STORE_FAST            9  'bonusName'

 L. 164       232  LOAD_CONST               0
              235  STORE_FAST           10  'totalVehicleBonus'

 L. 165       238  BUILD_LIST_0          0 
              241  STORE_FAST           11  'vehicleSlotBonuses'

 L. 166       244  LOAD_GLOBAL           4  'set'
              247  CALL_FUNCTION_0       0  None
              250  STORE_FAST           12  'vehicleNames'

 L. 167       253  SETUP_LOOP          279  'to 535'
              256  LOAD_FAST             0  'bonuses'
              259  GET_ITER         
              260  FOR_ITER            271  'to 534'
              263  STORE_FAST           13  'bonus'

 L. 168       266  LOAD_GLOBAL           5  'False'
              269  STORE_FAST           14  'wasMergedBonus'

 L. 169       272  SETUP_LOOP          111  'to 386'
              275  LOAD_FAST             2  'mergeBonusNames'
              278  GET_ITER         
              279  FOR_ITER            103  'to 385'
              282  STORE_FAST           15  'name'

 L. 170       285  LOAD_FAST             8  'checkBonus'
              288  LOAD_FAST            15  'name'
              291  BINARY_SUBSCR    
              292  LOAD_FAST            13  'bonus'
              295  CALL_FUNCTION_1       1  None
              298  POP_JUMP_IF_FALSE   279  'to 279'

 L. 171       301  LOAD_FAST             3  'bonusesForMerge'
              304  LOAD_FAST            15  'name'
              307  BINARY_SUBSCR    
              308  LOAD_ATTR             6  'append'
              311  LOAD_FAST            13  'bonus'
              314  CALL_FUNCTION_1       1  None
              317  POP_TOP          

 L. 172       318  LOAD_FAST             4  'usedNations'
              321  LOAD_FAST            15  'name'
              324  BINARY_SUBSCR    
              325  LOAD_ATTR             7  'update'
              328  LOAD_FAST             7  'getNation'
              331  LOAD_FAST            15  'name'
              334  BINARY_SUBSCR    
              335  LOAD_FAST            13  'bonus'
              338  CALL_FUNCTION_1       1  None
              341  CALL_FUNCTION_1       1  None
              344  POP_TOP          

 L. 173       345  LOAD_FAST             5  'value'
              348  LOAD_FAST            15  'name'
              351  BINARY_SUBSCR    
              352  LOAD_ATTR             6  'append'
              355  LOAD_FAST             6  'getValue'
              358  LOAD_FAST            15  'name'
              361  BINARY_SUBSCR    
              362  LOAD_FAST            13  'bonus'
              365  CALL_FUNCTION_1       1  None
              368  CALL_FUNCTION_1       1  None
              371  POP_TOP          

 L. 174       372  LOAD_GLOBAL           8  'True'
              375  STORE_FAST           14  'wasMergedBonus'

 L. 175       378  BREAK_LOOP       
              379  JUMP_BACK           279  'to 279'
              382  JUMP_BACK           279  'to 279'
              385  POP_BLOCK        
            386_0  COME_FROM           272  '272'

 L. 176       386  LOAD_FAST            14  'wasMergedBonus'
              389  POP_JUMP_IF_TRUE    260  'to 260'

 L. 177       392  LOAD_GLOBAL           9  'isinstance'
              395  LOAD_FAST            13  'bonus'
              398  LOAD_GLOBAL          10  'VehiclesBonus'
              401  CALL_FUNCTION_2       2  None
              404  POP_JUMP_IF_FALSE   463  'to 463'

 L. 178       407  LOAD_FAST            13  'bonus'
              410  LOAD_ATTR            11  'formatValue'
              413  CALL_FUNCTION_0       0  None
              416  LOAD_FAST            12  'vehicleNames'
              419  COMPARE_OP            6  in
            422_0  COME_FROM           389  '389'
              422  POP_JUMP_IF_FALSE   431  'to 431'

 L. 179       425  CONTINUE            260  'to 260'
              428  JUMP_FORWARD          0  'to 431'
            431_0  COME_FROM           428  '428'

 L. 180       431  LOAD_FAST            10  'totalVehicleBonus'
              434  LOAD_CONST               1
              437  INPLACE_ADD      
              438  STORE_FAST           10  'totalVehicleBonus'

 L. 181       441  LOAD_FAST            12  'vehicleNames'
              444  LOAD_ATTR            12  'add'
              447  LOAD_FAST            13  'bonus'
              450  LOAD_ATTR            11  'formatValue'
              453  CALL_FUNCTION_0       0  None
              456  CALL_FUNCTION_1       1  None
              459  POP_TOP          
              460  JUMP_FORWARD          0  'to 463'
            463_0  COME_FROM           460  '460'

 L. 182       463  LOAD_FAST            13  'bonus'
              466  LOAD_ATTR            13  'getName'
              469  CALL_FUNCTION_0       0  None
              472  LOAD_CONST               'slots'
              475  COMPARE_OP            2  ==
              478  POP_JUMP_IF_FALSE   515  'to 515'
              481  LOAD_FAST            13  'bonus'
              484  LOAD_ATTR            14  'getCount'
              487  CALL_FUNCTION_0       0  None
              490  LOAD_CONST               1
              493  COMPARE_OP            2  ==
            496_0  COME_FROM           478  '478'
              496  POP_JUMP_IF_FALSE   515  'to 515'

 L. 183       499  LOAD_FAST            11  'vehicleSlotBonuses'
              502  LOAD_ATTR             6  'append'
              505  LOAD_FAST            13  'bonus'
              508  CALL_FUNCTION_1       1  None
              511  POP_TOP          
              512  JUMP_ABSOLUTE       531  'to 531'

 L. 185       515  LOAD_FAST             1  'finalBonuses'
              518  LOAD_ATTR             6  'append'
              521  LOAD_FAST            13  'bonus'
              524  CALL_FUNCTION_1       1  None
              527  POP_TOP          
              528  JUMP_BACK           260  'to 260'
              531  JUMP_BACK           260  'to 260'
              534  POP_BLOCK        
            535_0  COME_FROM           253  '253'

 L. 187       535  LOAD_FAST             1  'finalBonuses'
              538  LOAD_FAST            11  'vehicleSlotBonuses'
              541  LOAD_FAST            10  'totalVehicleBonus'
              544  SLICE+1          
              545  INPLACE_ADD      
              546  STORE_FAST            1  'finalBonuses'

 L. 189       549  SETUP_LOOP          144  'to 696'
              552  LOAD_FAST             2  'mergeBonusNames'
              555  GET_ITER         
              556  FOR_ITER            136  'to 695'
              559  STORE_FAST           15  'name'

 L. 190       562  BUILD_LIST_0          0 
              565  LOAD_GLOBAL          15  'GUI_NATIONS'
              568  GET_ITER         
              569  FOR_ITER             28  'to 600'
              572  STORE_FAST           16  'nation'
              575  LOAD_FAST            16  'nation'
              578  LOAD_FAST             4  'usedNations'
              581  LOAD_FAST            15  'name'
              584  BINARY_SUBSCR    
              585  COMPARE_OP            6  in
              588  POP_JUMP_IF_FALSE   569  'to 569'
              591  LOAD_FAST            16  'nation'
              594  LIST_APPEND           2  None
              597  JUMP_BACK           569  'to 569'
              600  STORE_FAST           17  'nations'

 L. 191       603  LOAD_CONST               (1, None)
              606  STORE_FAST           18  'countAndValue'

 L. 192       609  LOAD_FAST             5  'value'
              612  LOAD_FAST            15  'name'
              615  BINARY_SUBSCR    
              616  POP_JUMP_IF_FALSE   638  'to 638'

 L. 193       619  LOAD_GLOBAL          17  'max'
              622  LOAD_FAST             5  'value'
              625  LOAD_FAST            15  'name'
              628  BINARY_SUBSCR    
              629  CALL_FUNCTION_1       1  None
              632  STORE_FAST           18  'countAndValue'
              635  JUMP_FORWARD          0  'to 638'
            638_0  COME_FROM           635  '635'

 L. 194       638  LOAD_FAST             1  'finalBonuses'
              641  LOAD_GLOBAL          18  'len'
              644  LOAD_FAST            17  'nations'
              647  CALL_FUNCTION_1       1  None
              650  LOAD_CONST               1
              653  COMPARE_OP            4  >
              656  POP_JUMP_IF_FALSE   681  'to 681'
              659  LOAD_GLOBAL          19  'LootBoxRandomNationalBonus'
              662  LOAD_FAST             9  'bonusName'
              665  LOAD_FAST            15  'name'
              668  BINARY_SUBSCR    
              669  LOAD_FAST            18  'countAndValue'
              672  CALL_FUNCTION_2       2  None
              675  BUILD_LIST_1          1 
              678  JUMP_FORWARD          7  'to 688'

 L. 195       681  LOAD_FAST             3  'bonusesForMerge'
              684  LOAD_FAST            15  'name'
              687  BINARY_SUBSCR    
            688_0  COME_FROM           678  '678'
              688  INPLACE_ADD      
              689  STORE_FAST            1  'finalBonuses'
              692  JUMP_BACK           556  'to 556'
              695  POP_BLOCK        
            696_0  COME_FROM           549  '549'

 L. 197       696  LOAD_GLOBAL          20  'AwardsManager'
              699  LOAD_ATTR            21  'sortBonuses'
              702  LOAD_FAST             1  'finalBonuses'
              705  LOAD_GLOBAL           8  'True'
              708  CALL_FUNCTION_2       2  None
              711  RETURN_VALUE     

Parse error at or near `JUMP_ABSOLUTE' instruction at offset 512


def _getBonusCount(bonusModel):
    bonusName = bonusModel.getName()
    if bonusName in Currency.ALL or bonusName in ('vehicles', Currency.FREE_XP, PREMIUM_ENTITLEMENTS.PLUS):
        return 1
    count = bonusModel.getCount()
    if not count:
        return 1
    return int(count)


def _getVehicleUIData(vehicle):
    return {'vehicleName': vehicle.shortUserName, 
       'vehicleType': getIconResourceName(vehicle.type), 
       'isElite': vehicle.isElite, 
       'vehicleLvl': int2roman(vehicle.level), 
       'vehicleLvlNum': vehicle.level}


def _getPreparedBonusModel(bonus):
    model = BonusModel()
    model.setName(bonus.getName())
    model.setIsCompensation(bonus.isCompensation())
    model.setRarity(AwardsManager.getRarity(bonus))
    return model


def _injectSpecialRewardName(item, postfix=''):
    if item.getRarity() in (BonusRarity.RARE, BonusRarity.EPIC):
        item.setSpecialAwardName(('_').join([item.getName(), postfix]) if postfix else item.getName())


class LootBoxSimpleBonusUIPacker(SimpleBonusUIPacker):

    @classmethod
    def _packSingleBonus(cls, bonus, label):
        model = _getPreparedBonusModel(bonus)
        model.setValue(str(bonus.getValue()))
        model.setIcon(bonus.getName())
        model.setLabel(label)
        return model

    @classmethod
    def _getToolTip(cls, bonus):
        if bonus.getName() == Currency.GOLD and bonus.isCompensation():
            return [
             createTooltipData(makeTooltip(header=backport.text(R.strings.tooltips.awardItem.gold.header()), body=backport.text(R.strings.tooltips.awardItem.gold.body()), note=backport.text(R.strings.tooltips.awardItem.gold.compensation())))]
        return super(LootBoxSimpleBonusUIPacker, cls)._getToolTip(bonus)


class LootBoxSpecialRandomBonusUIPacker(SimpleBonusUIPacker):

    @classmethod
    def _pack(cls, bonus):
        label = backport.text(R.strings.tooltips.awardItem.dyn(bonus.getName()).header())
        return [cls._packSingleBonus(bonus, label if label else '')]

    @classmethod
    def _packSingleBonus(cls, bonus, label):
        model = _getPreparedBonusModel(bonus)
        model.setCount(bonus.getCount())
        model.setIcon(bonus.getIconName())
        model.setLabel(label)
        return model

    @classmethod
    def _getContentId(cls, bonus):
        return [
         R.views.lobby.lootbox_system.tooltips.RandomNationalBonusTooltipView()]

    @classmethod
    def _getToolTip(cls, bonus):
        return [
         TooltipData(tooltip=None, isSpecial=True, specialAlias=None, specialArgs=[
          bonus.getName(), bonus.getValue(), bonus.getIconName()])]


class LootBoxSlotsBonusUIPacker(SimpleBonusUIPacker):

    @classmethod
    def _packSingleBonus(cls, bonus, label):
        model = _getPreparedBonusModel(bonus)
        model.setCount(bonus.getCount())
        model.setIcon(bonus.getName())
        model.setLabel(backport.text(R.strings.tooltips.awardItem.slots.header()))
        return model


class LootBoxTmanTemplateBonusUIPacker(SimpleBonusUIPacker):

    @classmethod
    def _pack(cls, bonus):
        result = []
        for tokenID, tokenRecord in bonus.getTokens().iteritems():
            if tokenID.startswith(RECRUIT_TMAN_TOKEN_PREFIX):
                count = tokenRecord.count
                packed = cls.__packTmanTemplateToken(tokenID, bonus, count)
                if packed is None:
                    _logger.error('Received wrong tman_template token from server: %s', tokenID)
                else:
                    result.append(packed)

        return result

    @classmethod
    def __packTmanTemplateToken(cls, tokenID, bonus, count):
        recruit = getRecruitInfo(tokenID)
        if recruit is None:
            return
        else:
            model = _getPreparedBonusModel(bonus)
            model.setCount(count)
            model.setIcon(cls.__getBonusImageName(recruit))
            model.setLabel(recruit.getFullUserName())
            model.setValue(recruit.getGroupName())
            groupName = recruit.getGroupName()
            model.setValue('' if groupName in ('men1', 'women1') else groupName)
            _injectSpecialRewardName(model, recruit.getGroupName())
            return model

    @classmethod
    def __getBonusImageName(cls, recruitInfo):
        baseName = ('tank{}man').format('wo' if recruitInfo.isFemale() else '')
        return baseName

    @classmethod
    def _getToolTip(cls, bonus):
        tooltipData = []
        for tokenID in bonus.getTokens().iterkeys():
            if tokenID.startswith(RECRUIT_TMAN_TOKEN_PREFIX):
                tooltipData.append(TooltipData(tooltip=None, isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.TANKMAN_NOT_RECRUITED, specialArgs=[
                 tokenID]))

        return tooltipData

    @classmethod
    def _getContentId(cls, bonus):
        result = []
        for tokenID in bonus.getTokens().iterkeys():
            if tokenID.startswith(RECRUIT_TMAN_TOKEN_PREFIX):
                result.append(BACKPORT_TOOLTIP_CONTENT_ID)

        return result


class LootBoxCustomizationsBonusUIPacker(BaseBonusUIPacker):
    __itemsCache = dependency.descriptor(IItemsCache)

    @classmethod
    def _pack(cls, bonus):
        result = []
        for item, data in zip(bonus.getCustomizations(), bonus.getList()):
            if item is None or cls.__isLockedStyle(bonus, item):
                continue
            result.append(cls._packSingleBonus(bonus, item, data))

        return result

    @classmethod
    def _packSingleBonus(cls, bonus, item, data):
        model = _getPreparedBonusModel(bonus)
        custItem = bonus.getC11nItem(item)
        itemName = custItem.itemTypeName
        description = custItem.userType
        if itemName == 'style':
            description = backport.text(R.strings.lootbox_system.bonuses.description.style())
            vehicleCD = getSingleVehicleCDForCustomization(custItem)
            model.setIsInHangar(vehicleCD is not None and custItem.fullInventoryCount() > 0)
            if custItem.modelsSet:
                itemName = 'style_3d'
                description = backport.text(R.strings.lootbox_system.bonuses.description.style3D())
                vehicle = cls.__itemsCache.items.getItemByCD(vehicleCD) if vehicleCD is not None else None
                if vehicle is not None:
                    model.setIsElite(vehicle.isElite)
                    model.setLevel(vehicle.level)
                    model.setType(VehicleType(vehicle.type))
                    model.setVehicle3DStyleName(vehicle.userName)
        model.setId(custItem.id)
        model.setCount(item.get('value', 0))
        model.setIcon(itemName)
        model.setLabel(cls._getLabel(custItem))
        model.setDescription(description)
        _injectSpecialRewardName(model, str(custItem.id))
        return model

    @classmethod
    def _getToolTip(cls, bonus):
        tooltipData = []
        for item, _ in zip(bonus.getCustomizations(), bonus.getList()):
            if item is None:
                continue
            itemCustomization = bonus.getC11nItem(item)
            specialAlias = TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM_AWARD
            specialArgs = CustomizationTooltipContext(itemCD=itemCustomization.intCD)
            if itemCustomization.itemTypeName in ('camouflage', 'style'):
                vehicle = getSingleVehicleCDForCustomization(itemCustomization)
                if vehicle is not None:
                    specialAlias = TOOLTIPS_CONSTANTS.TECH_CUSTOMIZATION_ITEM
                    specialArgs = CustomizationTooltipContext(itemCD=itemCustomization.intCD, vehicleIntCD=vehicle)
            tooltipData.append(TooltipData(tooltip=None, isSpecial=True, specialAlias=specialAlias, specialArgs=specialArgs))

        return tooltipData

    @classmethod
    def _getContentId(cls, bonus):
        result = []
        for item, _ in zip(bonus.getCustomizations(), bonus.getList()):
            if item is not None:
                result.append(BACKPORT_TOOLTIP_CONTENT_ID)

        return result

    @classmethod
    def _getLabel(cls, customizationItem):
        return customizationItem.userName

    @classmethod
    def __isLockedStyle(cls, bonus, item):
        customizationItem = bonus.getC11nItem(item)
        return customizationItem.itemTypeName == 'style' and customizationItem.isLockedOnVehicle


class LootBoxGoodiesBonusUIPacker(GoodiesBonusUIPacker):

    @classmethod
    def _packSingleBoosterBonus(cls, bonus, booster, count):
        return cls._packIconBonusModel(bonus, booster.getFullNameForResource(), count, backport.text(R.strings.menu.booster.label.dyn(booster.boosterGuiType)(), effectValue=booster.getFormattedValue()), description=backport.text(R.strings.lootbox_system.bonuses.description.booster()))

    @classmethod
    def _packIconBonusModel(cls, bonus, icon, count, label, description=''):
        model = _getPreparedBonusModel(bonus)
        model.setCount(count)
        model.setIcon(icon)
        model.setLabel(label)
        model.setDescription(description)
        return model


class LootBoxBlueprintBonusUIPacker(BlueprintBonusUIPacker):

    @classmethod
    def _pack(cls, bonus):
        model = _getPreparedBonusModel(bonus)
        model.setIcon(bonus.getImageCategory())
        model.setLabel(bonus.getBlueprintTooltipName())
        model.setCount(bonus.getCount())
        return [model]

    @staticmethod
    def getTooltip(bonuses):
        fragmentCDs = [ bonus.getBlueprintSpecialArgs() for bonus in bonuses ]
        specialAlias = [ bonus.getBlueprintSpecialAlias() for bonus in bonuses ]
        return TooltipData(tooltip=None, isSpecial=True, specialAlias=specialAlias, specialArgs=[
         fragmentCDs])


class LootBoxItemBonusUIPacker(ItemBonusUIPacker):

    @classmethod
    def _packSingleBonus(cls, bonus, item, count):
        model = _getPreparedBonusModel(bonus)
        model.setCount(count)
        icon, overlay = (item.name, '') if item.itemTypeID == GUI_ITEM_TYPE.BATTLE_BOOSTER else (
         item.getGUIEmblemID(), item.getOverlayType())
        model.setIcon(icon)
        model.setOverlayType(overlay)
        model.setLabel(item.userName)
        if item.itemTypeID == GUI_ITEM_TYPE.BATTLE_BOOSTER:
            model.setDescription(backport.text(R.strings.lootbox_system.bonuses.description.battle_booster()))
        elif item.itemTypeID == GUI_ITEM_TYPE.OPTIONALDEVICE and item.isRegular:
            model.setDescription(backport.text(R.strings.lootbox_system.bonuses.description.standard_equipment()))
        return model


class LootBoxCrewBookBonusUIPacker(CrewBookBonusUIPacker):

    @classmethod
    def _packSingleBonus(cls, bonus, book, count):
        model = _getPreparedBonusModel(bonus)
        model.setCount(count)
        model.setLabel(book.userName)
        model.setIcon(book.getBonusIconName())
        return model


class LootBoxCrewSkinBonusUIPacker(CrewSkinBonusUIPacker):

    @classmethod
    def _packSingleBonus(cls, bonus, crewSkin, count, label):
        model = _getPreparedBonusModel(bonus)
        model.setCount(count)
        model.setIcon(str(crewSkin.itemTypeName + str(crewSkin.getRarity())))
        model.setLabel(label)
        model.setDescription(backport.text(R.strings.lootbox_system.bonuses.description.crewSkin()))
        return model


class LootBoxesLootBoxBonusUIPacker(SimpleBonusUIPacker):

    @classmethod
    def _pack(cls, bonus):
        return [
         cls._packSingleBonus(bonus)]

    @classmethod
    def _packSingleBonus(cls, bonus):
        model = _getPreparedBonusModel(bonus)
        box = bonus.getBox()
        model.setId(bonus.lootBoxID)
        model.setIcon(box.getCategory() if box else bonus.getName())
        model.setCount(bonus.getCount())
        model.setLabel(box.getUserName() if box else '')
        _injectSpecialRewardName(model, str(bonus.lootBoxID))
        return model

    @classmethod
    def _getContentId(cls, _):
        return [R.views.lobby.lootbox_system.tooltips.BoxTooltip()]


class LootBoxTokenBonusUIPacker(TokenBonusUIPacker):

    @classmethod
    def _packToken(cls, bonusPacker, bonus, *args):
        model = _getPreparedBonusModel(bonus)
        return bonusPacker(model, bonus, *args)

    @classmethod
    def _getTokenBonusPackers(cls):
        return {BATTLE_BONUS_X5_TOKEN: cls.__packBattleBonusX5Token, 
           CREW_BONUS_X3_TOKEN: cls.__packCrewBonusX3Token}

    @classmethod
    def _getTooltipsPackers(cls):
        packers = super(LootBoxTokenBonusUIPacker, cls)._getTooltipsPackers()
        return {BATTLE_BONUS_X5_TOKEN: packers[BATTLE_BONUS_X5_TOKEN], 
           CREW_BONUS_X3_TOKEN: packers[CREW_BONUS_X3_TOKEN]}

    @classmethod
    def __packBattleBonusX5Token(cls, model, bonus, *args):
        model.setCount(bonus.getCount())
        model.setLabel(backport.text(R.strings.tooltips.quests.bonuses.token.battle_bonus_x5.label()))
        model.setIcon(BATTLE_BONUS_X5_TOKEN)
        return model

    @classmethod
    def __packCrewBonusX3Token(cls, model, bonus, *args):
        model.setCount(bonus.getCount())
        model.setLabel(backport.text(R.strings.tooltips.quests.bonuses.token.crew_bonus_x3.label()))
        model.setIcon(CREW_BONUS_X3_TOKEN)
        return model


class LootBoxPremiumBonusUIPacker(BaseBonusUIPacker):
    _ICONS_AVAILABLE = (1, 2, 3, 7, 14, 30, 90, 180, 360)

    @classmethod
    def _pack(cls, bonus):
        return [
         cls._packSingleBonus(bonus)]

    @classmethod
    def _packSingleBonus(cls, bonus):
        model = _getPreparedBonusModel(bonus)
        icon = 'premium_plus_universal'
        days = bonus.getValue()
        if days in cls._ICONS_AVAILABLE:
            icon = ('{}_{}').format(bonus.getName(), str(days))
        model.setName(bonus.getName())
        model.setIcon(icon)
        model.setIsCompensation(bonus.isCompensation())
        model.setValue(str(days))
        model.setLabel(backport.text(R.strings.tooltips.awardItem.premium_plus.header()))
        return model


class LootBoxVehiclesBonusUIPacker(VehiclesBonusUIPacker):

    @classmethod
    def _packVehicles(cls, bonus, vehicles):
        return [ cls._packVehicle(bonus, vehInfo, vehicle) for vehicle, vehInfo in vehicles ]

    @classmethod
    def _packVehicleBonusModel(cls, bonus, vehInfo, isRent, vehicle):
        model = _getPreparedBonusModel(bonus)
        styleID = vehInfo.get('customization', {}).get('styleId')
        if styleID is not None and vehicle.isOutfitLocked:
            model.setStyleID(styleID)
        model.setName(bonus.getName())
        model.setIsRent(isRent)
        compensation = cls.__getCompensation(bonus, vehInfo)
        model.setIsCompensation(bool(compensation))
        if compensation:
            for bonusComp in compensation:
                model.compensation.setName(bonusComp.getName())
                model.compensation.setValue(str(bonusComp.getValue()))
                model.compensation.setIcon(bonusComp.getName())
                model.compensation.setLabel(getLocalizedBonusName(bonusComp.getName()))

        cls.__fillVehicleInfo(model, vehicle)
        _injectSpecialRewardName(model, str(vehicle.intCD))
        return model

    @classmethod
    def __fillVehicleInfo(cls, model, vehicle):
        model.setIsInHangar(vehicle.isInInventory)
        model.setId(vehicle.intCD)
        model.setLabel(vehicle.userName)
        model.setVehicleShortName(vehicle.shortUserName)
        model.setType(VehicleType(vehicle.type))
        model.setLevel(vehicle.level)
        model.setIsElite(vehicle.isElite)
        model.setIcon(getUnicName(vehicle.name))

    @classmethod
    def _packTooltips(cls, bonus, vehicles):
        packedTooltips = []
        for vehicle, vehInfo in vehicles:
            compensation = cls.__getCompensation(bonus, vehInfo)
            if compensation:
                for bonusComp in compensation:
                    packedTooltips.extend(cls._packCompensationTooltip(bonusComp, vehicle))

            else:
                packedTooltips.append(cls._packTooltip(bonus, vehicle, vehInfo))

        return packedTooltips

    @classmethod
    def _packTooltip(cls, bonus, vehicle, vehInfo):
        compensation = cls.__getCompensation(bonus, vehInfo)
        if compensation:
            return first(cls._packCompensationTooltip(first(compensation), vehicle))
        return super(LootBoxVehiclesBonusUIPacker, cls)._packTooltip(bonus, vehicle, vehInfo)

    @classmethod
    def _packCompensationTooltip(cls, bonusComp, vehicle):
        tooltipDataList = super(LootBoxVehiclesBonusUIPacker, cls)._packCompensationTooltip(bonusComp, vehicle)
        return [ cls.__convertCompensationTooltip(bonusComp, vehicle, tooltipData) for tooltipData in tooltipDataList ]

    @classmethod
    def _getContentId(cls, bonus):
        outcome = []
        for _, vehInfo in bonus.getVehicles():
            compensation = cls.__getCompensation(bonus, vehInfo)
            if compensation:
                outcome.append(VEH_COMP_R_ID)
            else:
                outcome.append(BACKPORT_TOOLTIP_CONTENT_ID)

        return outcome

    @classmethod
    def __convertCompensationTooltip(cls, bonusComp, vehicle, tooltipData):
        iconAfterRes = R.images.gui.maps.icons.quests.bonuses.big.dyn(bonusComp.getName())
        if not iconAfterRes.exists():
            iconAfterRes = R.images.gui.maps.icons.quests.bonuses.big.gold
        specialArgs = {'labelBefore': '', 
           'iconAfter': backport.image(iconAfterRes()), 
           'labelAfter': bonusComp.getIconLabel(), 
           'bonusName': bonusComp.getName()}
        uiData = _getVehicleUIData(vehicle)
        formattedTypeName = uiData['vehicleType']
        isElite = vehicle.isElite
        uiData['vehicleType'] = ('{}_elite').format(formattedTypeName) if isElite else formattedTypeName
        specialArgs.update(uiData)
        vehicleName = getNationLessName(vehicle.name)
        vehIcon = R.images.gui.maps.shop.vehicles.c_180x135.dyn(vehicleName)()
        if vehIcon < 1:
            vehicleName = vehicleName.replace('-', '_')
            vehIcon = R.images.gui.maps.shop.vehicles.c_180x135.dyn(vehicleName)()
        specialArgs['iconBefore'] = backport.image(vehIcon) if vehIcon > 0 else ''
        return createTooltipData(tooltip=tooltipData.tooltip, specialAlias=VEH_COMP_R_ID, specialArgs=specialArgs)

    @classmethod
    def __getCompensation(cls, bonus, vehInfo):
        compBonuses = []
        compensatedNumber = vehInfo.get('compensatedNumber', 0)
        compensation = vehInfo.get('customCompensation')
        if compensatedNumber and compensation is not None:
            money = Money(*compensation)
            for currency, value in money.iteritems():
                if value:
                    bonusClass = _BONUSES.get(currency)
                    compBonuses.append(bonusClass(currency, value, isCompensation=True, compensationReason=bonus))

        return compBonuses# Decompile failed :(