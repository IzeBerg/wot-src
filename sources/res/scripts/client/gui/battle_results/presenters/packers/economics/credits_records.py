from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS as _CAPS
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.battle_results.currency_value_model import ValueModifiers
from gui.battle_results.presenters.packers.economics.base_currency_packer import CurrencyRecord
from gui.battle_results.presenters.packers.economics.value_extractors import getCreditsFromAdditional, getMainValue, getMainEarnedValue, getEventValue, getTotalCreditsValue, getWotPlusBonusValue
from gui.battle_results.settings import CurrenciesConstants
_STR_PATH = R.strings.battle_results.details.calculations
BASE_EARNED = CurrencyRecord(recordNames=('originalCredits', 'originalCreditsToDraw',
                                          'appliedPremiumCreditsFactor100'), subtractRecords=('achievementCredits', ), valueExtractor=getMainEarnedValue, capsToBeChecked=None, label=_STR_PATH.base, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
SQUAD_BONUS = CurrencyRecord(recordNames=('originalPremSquadCredits', 'originalCreditsToDrawSquad'), subtractRecords=(), valueExtractor=getMainValue, capsToBeChecked={
 _CAPS.PREM_SQUAD_CREDITS}, label=_STR_PATH.squadBonus, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
ACHIEVEMENTS = CurrencyRecord(recordNames=('achievementCredits', ), subtractRecords=(), valueExtractor=getMainValue, capsToBeChecked=None, label=_STR_PATH.noPenalty, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
BOOSTERS = CurrencyRecord(recordNames=('boosterCredits', 'boosterCreditsFactor100'), subtractRecords=(), valueExtractor=getMainValue, capsToBeChecked=None, label=_STR_PATH.boosters, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
BATTLE_PAYMENTS = CurrencyRecord(recordNames=('orderCreditsFactor100', ), subtractRecords=(), valueExtractor=getMainValue, capsToBeChecked=None, label=_STR_PATH.battlePayments, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
EVENT_PAYMENTS = CurrencyRecord(recordNames=('eventCreditsList_', 'eventCreditsFactor100List_'), subtractRecords=(), valueExtractor=getEventValue, capsToBeChecked=None, label=_STR_PATH.event, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
REFERRAL_BONUS = CurrencyRecord(recordNames=('referral20CreditsFactor100', ), subtractRecords=(), valueExtractor=getMainValue, capsToBeChecked=None, label=_STR_PATH.referralBonus.simpleLabel, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
WOT_PLUS_BONUS = CurrencyRecord(recordNames=('wotPlusCredits', 'wotPlusCreditsFactor100'), subtractRecords=(), valueExtractor=getWotPlusBonusValue, capsToBeChecked=None, label=_STR_PATH.wotPlus, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
FRIENDLY_FIRE_PENALTY = CurrencyRecord(recordNames=('originalCreditsPenalty', 'originalCreditsContributionOut',
                                                    'originalCreditsPenaltySquad',
                                                    'originalCreditsContributionOutSquad'), subtractRecords=(), valueExtractor=getMainValue, capsToBeChecked=None, label=_STR_PATH.friendlyFirePenalty, modifiers=(
 ValueModifiers.SUB,), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
FRIENDLY_FIRE_COMPENSATION = CurrencyRecord(recordNames=('originalCreditsContributionIn',
                                                         'originalCreditsContributionInSquad'), subtractRecords=(), valueExtractor=getMainValue, capsToBeChecked=None, label=_STR_PATH.friendlyFireCompensation, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
PIGGY_BANK = CurrencyRecord(recordNames=('piggyBank', ), subtractRecords=(), valueExtractor=getCreditsFromAdditional, capsToBeChecked={
 _CAPS.PIGGY_BANK_CREDITS}, label=_STR_PATH.piggyBankInfo, modifiers=(
 ValueModifiers.ADD,), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
AUTO_REPAIR_COST = CurrencyRecord(recordNames=('autoRepairCost', ), subtractRecords=(), valueExtractor=getCreditsFromAdditional, capsToBeChecked={
 _CAPS.DAMAGE_VEHICLE}, label=_STR_PATH.autoRepair, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
AUTO_LOAD_COST = CurrencyRecord(recordNames=('autoLoadCredits', ), subtractRecords=(), valueExtractor=getCreditsFromAdditional, capsToBeChecked=None, label=_STR_PATH.autoLoad, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
AUTO_EQUIP_COST = CurrencyRecord(recordNames=('autoEquipCredits', ), subtractRecords=(), valueExtractor=getCreditsFromAdditional, capsToBeChecked=None, label=_STR_PATH.autoEquip, modifiers=(), showZeroValue=False, currencyType=CurrenciesConstants.CREDITS)
TOTAL_CREDITS = CurrencyRecord(recordNames=('credits', 'originalCreditsToDraw', 'originalCreditsToDrawSquad'), subtractRecords=('autoRepairCost',
                                                                                                                                'autoLoadCredits',
                                                                                                                                'autoEquipCredits'), valueExtractor=getTotalCreditsValue, capsToBeChecked=None, label=_STR_PATH.title.total, modifiers=(), showZeroValue=True, currencyType=CurrenciesConstants.CREDITS)