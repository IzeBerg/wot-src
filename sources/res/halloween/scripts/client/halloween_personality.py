from account_helpers.AccountSettings import AccountSettings, KEY_SETTINGS
from constants import HAS_DEV_RESOURCES
from constants_utils import initCommonTypes, initSquadCommonTypes, addBattleEventTypesFromExtension, addAttackReasonTypesFromExtension, addDamageInfoCodes, addDamageResistanceReasonsFromExtension, addQueueTypeByUnitMgrRoster, addInvitationTypeFromArenaBonusTypeMapping
from debug_utils import LOG_DEBUG
from aih_constants import CTRL_TYPE, CTRL_MODE_NAME
from halloween.gui.battle_control.controllers.equipment_items import registerHWEquipmentsItems
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.managers.loaders import g_viewOverrider
from halloween.gui.halloween_account_settings import ACCOUNT_DEFAULT_SETTINGS
from halloween.gui.halloween_gui_constants import HALLOWEEN_TOOLTIP_SET, LUI_RULES_HW
from halloween.gui.register_additional_params import registerAdditionalParams, initAdditionalGuiTypes
from halloween.gui.scaleform.genConsts.HALLOWEEN_HANGAR_ALIASES import HALLOWEEN_HANGAR_ALIASES
from halloween.gui.shared.tooltips.hw_advanced import registerHWEquipmentTooltipMovies
from halloween.overrides.hangar_override import HangarOverride
from halloween.overrides.battl_equeue_override import BattleQueueOverride
from halloween_common import halloween_constants
from halloween.gui import halloween_gui_constants
from halloween.gui.battle_control import halloween_battle_constants
from halloween.control_modes import HWArcadeControlMode, HWSniperControlMode
from gui.override_scaleform_views_manager import g_overrideScaleFormViewsConfig
from gui.prb_control.prb_utils import initGuiTypes, initScaleformGuiTypes, initBattleCtrlIDs
from gui.shared.system_factory import registerScaleformBattlePackages, registerLobbyTooltipsBuilders
from messenger.m_constants import BATTLE_CHANNEL
from chat_shared import SYS_MESSAGE_TYPE as _SM_TYPE

class ClientHalloweenBattleMode(halloween_constants.HalloweenBattleMode):
    _CLIENT_BATTLE_PAGE = halloween_gui_constants.VIEW_ALIAS.HALLOWEEN_BATTLE_PAGE
    _CLIENT_PRB_ACTION_NAME = halloween_gui_constants.PREBATTLE_ACTION_NAME.HALLOWEEN
    _CLIENT_PRB_ACTION_NAME_SQUAD = halloween_gui_constants.PREBATTLE_ACTION_NAME.HALLOWEEN_SQUAD
    _CLIENT_BANNER_ENTRY_POINT_ALIAS = HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_ENTRY_POINT

    @property
    def _client_prbEntityClass(self):
        from halloween.gui.prb_control.entities.pre_queue.entity import HalloweenEntity
        return HalloweenEntity

    @property
    def _client_canSelectPrbEntity(self):
        from halloween.gui.prb_control.entities.pre_queue.entity import canSelectPrbEntity
        return canSelectPrbEntity

    @property
    def _client_prbEntryPointClass(self):
        from halloween.gui.prb_control.entities.pre_queue.entity import HalloweenEntryPoint
        return HalloweenEntryPoint

    @property
    def _client_bannerEntryPointValidatorMethod(self):
        from halloween.gui.impl.lobby.feature.halloween_entry_point_view import isHalloweenEntryPointAvailable
        return isHalloweenEntryPointAvailable

    @property
    def _client_bannerEntryPointLUIRule(self):
        from gui.limited_ui.lui_rules_storage import LUI_RULES
        LUI_RULES.inject(LUI_RULES_HW)
        return LUI_RULES.HalloweenEntryPoint

    @property
    def _client_gameControllers(self):
        from halloween.skeletons.halloween_controller import IHalloweenController
        from halloween.gui.game_control.halloween_controller import HalloweenController
        from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
        from halloween.gui.game_control.difficulty_level_controller import DifficultyLevelController
        from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
        from halloween.gui.game_control.halloween_artefacts_controller import HalloweenArtefactsController
        from halloween.skeletons.halloween_shop_controller import IHalloweenShopController
        from halloween.gui.game_control.halloween_shop_controller import HalloweenShopController
        from halloween.skeletons.halloween_sound_controller import IHalloweenSoundController
        from halloween.gui.sounds.halloween_sound_controller import HalloweenSoundController
        from halloween.skeletons.halloween_global_chat_controller import IHalloweenGlobalChatController
        from halloween.gui.game_control.halloween_global_chat_controller import HalloweenGlobalChatController
        return (
         (
          IHalloweenController, HalloweenController, False),
         (
          IDifficultyLevelController, DifficultyLevelController, False),
         (
          IHalloweenArtefactsController, HalloweenArtefactsController, False),
         (
          IHalloweenShopController, HalloweenShopController, False),
         (
          IHalloweenSoundController, HalloweenSoundController, False),
         (
          IHalloweenGlobalChatController, HalloweenGlobalChatController, False))

    @property
    def _client_selectorColumn(self):
        from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_columns import ModeSelectorColumns
        return (ModeSelectorColumns.COLUMN_1, -1)

    @property
    def _client_selectorItemsCreator(self):
        from halloween.gui.scaleform.daapi.view.lobby.header.battle_selector_items import addHalloweenType
        return addHalloweenType

    @property
    def _client_modeSelectorItemsClass(self):
        from halloween.gui.impl.lobby.mode_selector.halloween_selector_item import HalloweenSelectorItem
        return HalloweenSelectorItem

    @property
    def _client_prbSquadEntityClass(self):
        from halloween.gui.prb_control.entities.squad.entity import HalloweenSquadEntity
        return HalloweenSquadEntity

    @property
    def _client_prbSquadEntryPointClass(self):
        from halloween.gui.prb_control.entities.squad.entity import HalloweenEntryPoint
        return HalloweenEntryPoint

    @property
    def _client_selectorSquadItemsCreator(self):
        from halloween.gui.scaleform.daapi.view.lobby.header.battle_selector_items import addHalloweenSquadType
        return addHalloweenSquadType

    @property
    def _client_platoonViewClass(self):
        from halloween.gui.impl.lobby.platoon_members_view import HalloweenMembersView
        return HalloweenMembersView

    @property
    def _client_platoonWelcomeViewClass(self):
        from gui.impl.lobby.platoon.view.platoon_welcome_view import WelcomeView
        return WelcomeView

    @property
    def _client_platoonLayouts(self):
        from gui.impl.gen import R
        from gui.impl.lobby.platoon.platoon_config import EPlatoonLayout, MembersWindow, PlatoonLayout
        return [
         (
          EPlatoonLayout.MEMBER, PlatoonLayout(R.views.halloween.lobby.MembersWindow(), MembersWindow))]

    @property
    def _client_arenaDescrClass(self):
        from halloween.gui.battle_control.arena_info.halloween_arena_descrs import HalloweenArenaDescription
        return HalloweenArenaDescription

    @property
    def _client_squadFinderClass(self):
        from halloween.gui.battle_control.arena_info.halloween_squad_finder import HalloweenTeamScopeNumberingFinder
        return HalloweenTeamScopeNumberingFinder

    @property
    def _client_lobbyRequiredLibraries(self):
        return ['halloween|halloween_lobby.swf', 'halloween|halloween_common_i18n.swf', 'halloween|components.swf']

    @property
    def _client_battleRequiredLibraries(self):
        return ['halloween|halloween_battle.swf', 'halloween|halloween_common_i18n.swf']

    @property
    def _client_LobbyContextMenuOptions(self):
        from halloween.gui.scaleform.daapi.view.lobby.halloween_user_cm_handlers import CREATE_HALLOWEEN_SQUAD, halloweenSquadOptionBuilder, createHalloweenSquadHandler
        return (
         (
          CREATE_HALLOWEEN_SQUAD, halloweenSquadOptionBuilder, createHalloweenSquadHandler),)

    @property
    def _client_DynamicObjectCacheClass(self):
        from halloween_dyn_object_cache import _HalloweenDynObjects
        return _HalloweenDynObjects

    @property
    def _client_tokenQuestsSubFormatters(self):
        from halloween.messenger.formatters.token_quest_subformatters import HalloweenStarterBundleFormatter, HalloweenBattlePassPointsFormatter, HalloweenKingRewardFormatter
        return (
         HalloweenStarterBundleFormatter(), HalloweenBattlePassPointsFormatter(), HalloweenKingRewardFormatter())

    @property
    def _client_battleControllersRepository(self):
        from halloween.gui.battle_control.controllers.repositories import HalloweenControllerRepository
        return HalloweenControllerRepository

    @property
    def _client_sharedControllersRepository(self):
        from halloween.gui.battle_control.controllers.repositories import HalloweenSharedControllersRepository
        return HalloweenSharedControllersRepository

    @property
    def _client_battleChannelController(self):
        from halloween.messenger.gui.channel.bw_chat2.battle_channel_controller import HalloweenTeamChannelController
        return (
         BATTLE_CHANNEL.TEAM, HalloweenTeamChannelController)

    @property
    def _client_battleResultStatsCtrlClass(self):
        from halloween.gui.battle_results.composer import HalloweenBattleStatsComposer
        return HalloweenBattleStatsComposer

    @property
    def _client_battleResultsReusables(self):
        from halloween.gui.battle_results.reusable import REUSABLE_FACTORY_ITEMS
        return REUSABLE_FACTORY_ITEMS

    @property
    def _client_messengerServerFormatters(self):
        from halloween.messenger.formatters.service_channel import HWVehicleRentFormatter, HWArtefactKeysFormatter, HalloweenBattleResultsFormatter, HWDifficultyLevelFormatter, HWAutoMaintenanceFormatter
        return {_SM_TYPE.hwVehicleRentMessage.index(): HWVehicleRentFormatter(), 
           _SM_TYPE.hwArtefactKeysMessage.index(): HWArtefactKeysFormatter(), 
           _SM_TYPE.hwBattleResults.index(): HalloweenBattleResultsFormatter(), 
           _SM_TYPE.hwDifficultyRewardCongrats.index(): HWDifficultyLevelFormatter(), 
           _SM_TYPE.hwAutoMaintenance.index(): HWAutoMaintenanceFormatter()}

    @property
    def _client_customizationHangarDisabled(self):
        from halloween.gui.impl.lobby.hw_helpers import isCustomizationHangarDisabled
        return isCustomizationHangarDisabled

    @property
    def _client_advancedChatComponent(self):
        from halloween.arena_components.halloween_advanced_chat_component import HWAdvancedChatComponent
        return HWAdvancedChatComponent

    @property
    def _client_controlModes(self):
        return {CTRL_MODE_NAME.ARCADE: (
                                 HWArcadeControlMode, 'arcadeMode', CTRL_TYPE.USUAL), 
           CTRL_MODE_NAME.SNIPER: (
                                 HWSniperControlMode, 'sniperMode', CTRL_TYPE.USUAL)}

    @property
    def _client_equipmentTriggers(self):
        from halloween.gui.battle_control.controllers.equipment_triggers import _EventArtilleryItem, _ReplayEventArtilleryItem
        return [
         (
          'artillery_deathzone', _EventArtilleryItem, _ReplayEventArtilleryItem)]

    @property
    def _client_hangarPresetsReader(self):
        from halloween.gui.hangar_presets.hw_presets_reader import HalloweenPresetsReader
        return HalloweenPresetsReader

    @property
    def _client_hangarPresetsGetter(self):
        from halloween.gui.hangar_presets.hw_presets_getter import HalloweenPresetsGetter
        return HalloweenPresetsGetter

    @property
    def _client_guiItemsCacheInvalidators(self):
        from HWAccountEquipmentController import HWInventorySessionCache
        return [HWInventorySessionCache.hwInventoryVehInvalidator]

    @property
    def _client_lowPriorityWulfWindows(self):
        from gui.impl.gen import R
        return [R.views.halloween.lobby.HangarView()]


class ClientHalloweenMediumBattleMode(ClientHalloweenBattleMode):
    _ARENA_BONUS_TYPE = halloween_constants.ARENA_BONUS_TYPE.HALLOWEEN_MEDIUM
    _QUEUE_TYPE = halloween_constants.QUEUE_TYPE.HALLOWEEN_MEDIUM

    @property
    def _client_hangarPresetsReader(self):
        return

    @property
    def _client_hangarPresetsGetter(self):
        from halloween.gui.hangar_presets.hw_presets_getter import HalloweenMediumPresetsGetter
        return HalloweenMediumPresetsGetter


class ClientHalloweenHardBattleMode(ClientHalloweenBattleMode):
    _ARENA_BONUS_TYPE = halloween_constants.ARENA_BONUS_TYPE.HALLOWEEN_HARD
    _QUEUE_TYPE = halloween_constants.QUEUE_TYPE.HALLOWEEN_HARD

    @property
    def _client_hangarPresetsReader(self):
        return

    @property
    def _client_hangarPresetsGetter(self):
        from halloween.gui.hangar_presets.hw_presets_getter import HalloweenHardPresetsGetter
        return HalloweenHardPresetsGetter


class ClientHalloweenDefenceBattleMode(ClientHalloweenBattleMode):
    _ARENA_BONUS_TYPE = halloween_constants.ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE
    _CLIENT_BATTLE_PAGE = halloween_gui_constants.VIEW_ALIAS.HALLOWEEN_DEFENCE_BATTLE_PAGE
    _ARENA_GUI_TYPE = halloween_constants.ARENA_GUI_TYPE.HALLOWEEN_DEFENCE
    _QUEUE_TYPE = halloween_constants.QUEUE_TYPE.HALLOWEEN_DEFENCE

    @property
    def _client_lobbyRequiredLibraries(self):
        return []

    @property
    def _client_battleControllersRepository(self):
        from halloween.gui.battle_control.controllers.repositories import HalloweenDefenceControllerRepository
        return HalloweenDefenceControllerRepository

    def registerClientSelector(self):
        from gui.prb_control import prb_utils
        prb_utils.addSupportedQueues(self._QUEUE_TYPE, self._client_prbEntityClass, self._client_canSelectPrbEntity, self._personality)

    def registerSquadTypes(self):
        addQueueTypeByUnitMgrRoster(self._QUEUE_TYPE, self._ROSTER_TYPE, self._personality)
        addInvitationTypeFromArenaBonusTypeMapping(self._ARENA_BONUS_TYPE, self._INVITATION_TYPE, self._personality)

    def registerClientPlatoon(self):
        from gui.impl.lobby.platoon import platoon_config
        platoon_config.addQueueTypeToPrbSquadActionName(self._QUEUE_TYPE, self._CLIENT_PRB_ACTION_NAME_SQUAD, self._personality)

    def registerClientSquadSelector(self):
        from gui.prb_control import prb_utils
        prb_utils.addSquadFinder(self._ARENA_GUI_TYPE, self._client_squadFinderClass, self._rosterClass, self._personality)

    @property
    def _client_hangarPresetsReader(self):
        return

    @property
    def _client_hangarPresetsGetter(self):
        from halloween.gui.hangar_presets.hw_presets_getter import HalloweenDefencePresetsGetter
        return HalloweenDefencePresetsGetter


def preInit():
    LOG_DEBUG('preInit personality:', __name__)
    initCommonTypes(halloween_constants, __name__)
    initSquadCommonTypes(halloween_constants, __name__)
    initGuiTypes(halloween_gui_constants, __name__)
    initAdditionalGuiTypes(halloween_gui_constants, __name__)
    initScaleformGuiTypes(halloween_gui_constants, __name__)
    initBattleCtrlIDs(halloween_gui_constants, __name__)
    addBattleEventTypesFromExtension(halloween_constants.BATTLE_EVENT_TYPE, __name__)
    halloween_gui_constants.FEEDBACK_EVENT_ID.inject(__name__)
    halloween_battle_constants.VEHICLE_VIEW_STATE.inject(__name__)
    addAttackReasonTypesFromExtension(halloween_constants.ATTACK_REASON, __name__)
    addDamageResistanceReasonsFromExtension(halloween_constants.DamageResistanceReason, __name__)
    addDamageInfoCodes(halloween_constants.DAMAGE_INFO_CODES_PER_ATTACK_REASON, __name__)
    battleMode = ClientHalloweenBattleMode(__name__)
    battleMode.registerCommon()
    battleMode.registerClient()
    battleMode.registerClientSelector()
    battleMode.registerClientHangarPresets()
    battleMode.registerSquadTypes()
    battleMode.registerClientPlatoon()
    battleMode.registerClientSquadSelector()
    battleMode.registerBannerEntryPointValidatorMethod()
    battleMode.registerBannerEntryPointLUIRule()
    battleMode.registerGameControllers()
    battleMode.registerScaleformRequiredLibraries()
    battleMode.registerLobbyContextMenuOptions()
    battleMode.registerDynamicObjectCache()
    battleMode.registerBattleResultsConfig()
    battleMode.registerClientTokenQuestsSubFormatters()
    battleMode.registerBattleControllersRepository()
    battleMode.registerSharedControllersRepository()
    battleMode.registerBattleChannelController()
    battleMode.registerSystemMessagesTypes()
    battleMode.registerClientBattleResultsCtrl()
    battleMode.registerClientBattleResultReusabled()
    battleMode.registerClientSystemMessagesTypes()
    battleMode.registerMessengerServerFormatters()
    battleMode.registerBattleResultSysMsgType()
    battleMode.registerAutoMaintenanceSysMsgType()
    battleMode.registerCustomizationHangarDecorator()
    battleMode.registerClientEquipmentTriggers()
    battleMode.registerAttackReasonToCode()
    battleMode.registerClientAdvancedChatComponent()
    battleMode.registerControlModes()
    battleMode.registerGuiItemsCacheInvalidators()
    battleMode.registerLowPriorityWulfWindows()
    battleMediumMode = ClientHalloweenMediumBattleMode(__name__)
    battleMediumMode.registerCommon()
    battleMediumMode.registerClientHangarPresets()
    battleMediumMode.registerBattleResultsConfig()
    battleMediumMode.registerClientBattleResultsCtrl()
    battleMediumMode.registerClientBattleResultReusabled()
    battleMediumMode.registerClientAdvancedChatComponent()
    battleMediumMode.registerControlModes()
    battleHardMode = ClientHalloweenHardBattleMode(__name__)
    battleHardMode.registerCommon()
    battleHardMode.registerClientHangarPresets()
    battleHardMode.registerBattleResultsConfig()
    battleHardMode.registerClientBattleResultsCtrl()
    battleHardMode.registerClientBattleResultReusabled()
    battleHardMode.registerClientAdvancedChatComponent()
    battleHardMode.registerControlModes()
    battleDefenceMode = ClientHalloweenDefenceBattleMode(__name__)
    battleDefenceMode.registerCommon()
    battleDefenceMode.registerClient()
    battleDefenceMode.registerClientSelector()
    battleDefenceMode.registerClientHangarPresets()
    battleDefenceMode.registerSquadTypes()
    battleDefenceMode.registerClientPlatoon()
    battleDefenceMode.registerClientSquadSelector()
    battleDefenceMode.registerScaleformRequiredLibraries()
    battleDefenceMode.registerDynamicObjectCache()
    battleDefenceMode.registerBattleResultsConfig()
    battleDefenceMode.registerBattleControllersRepository()
    battleDefenceMode.registerSharedControllersRepository()
    battleDefenceMode.registerBattleChannelController()
    battleDefenceMode.registerClientBattleResultsCtrl()
    battleDefenceMode.registerClientBattleResultReusabled()
    battleDefenceMode.registerBattleResultSysMsgType()
    battleDefenceMode.registerClientAdvancedChatComponent()
    registerAdditionalParams(__name__)
    registerHWEquipmentTooltipMovies()
    registerHWEquipmentsItems()
    registerLobbyTooltipsBuilders([
     (
      'halloween.gui.scaleform.daapi.view.tooltips.tooltip_builders', HALLOWEEN_TOOLTIP_SET)])


def init():
    LOG_DEBUG('init', __name__)
    g_overrideScaleFormViewsConfig.initExtensionLobbyPackages(__name__, [
     'halloween.gui.scaleform.daapi.view.lobby',
     'halloween.gui.scaleform.daapi.view.lobby.store',
     'halloween.gui.scaleform.daapi.view.lobby.tank_setup'])
    BATTLE_PACKAGES = ('halloween.gui.scaleform.daapi.view.battle.shared', 'messenger.gui.Scaleform.view.battle')
    registerScaleformBattlePackages(halloween_constants.ARENA_GUI_TYPE.HALLOWEEN, BATTLE_PACKAGES)
    g_overrideScaleFormViewsConfig.initExtensionBattlePackages(__name__, [
     'halloween.gui.scaleform.daapi.view.battle'], halloween_constants.ARENA_GUI_TYPE.HALLOWEEN)
    registerScaleformBattlePackages(halloween_constants.ARENA_GUI_TYPE.HALLOWEEN_DEFENCE, BATTLE_PACKAGES)
    g_overrideScaleFormViewsConfig.initExtensionBattlePackages(__name__, [
     'halloween.gui.scaleform.daapi.view.defence_battle'], halloween_constants.ARENA_GUI_TYPE.HALLOWEEN_DEFENCE)
    if HAS_DEV_RESOURCES:
        from halloween.gui.development import prb_dev
        prb_dev.prbDevInit()
    g_viewOverrider.addOverride(VIEW_ALIAS.LOBBY_HANGAR, lambda *args, **kwargs: HangarOverride())
    g_viewOverrider.addOverride(VIEW_ALIAS.BATTLE_QUEUE, lambda *args, **kwargs: BattleQueueOverride())
    AccountSettings.overrideDefaultSettings(KEY_SETTINGS, ACCOUNT_DEFAULT_SETTINGS)


def start():
    pass


def fini():
    if HAS_DEV_RESOURCES:
        from halloween.gui.development import prb_dev
        prb_dev.prbDevFini()