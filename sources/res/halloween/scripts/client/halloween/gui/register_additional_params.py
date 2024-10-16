from helpers import dependency
from gui.prb_control.prb_utils import addSupportedQueues, addArenaGUITypeByQueueType, addQueueTypeToPrbType
from gui.prb_control.settings import PREBATTLE_TYPE_TO_QUEUE_TYPE
from halloween.messenger.formatters.invites import HalloweenPrbInviteHtmlTextFormatter
from halloween.gui import halloween_gui_constants
from halloween.gui.prb_control.entities.pre_queue.entity import canSelectPrbEntity, HalloweenEntity
from halloween_common.halloween_constants import QUEUE_TYPE, ARENA_GUI_TYPE, PREBATTLE_TYPE
from gui.impl.lobby.platoon.platoon_config import addQueueTypeToPrbSquadActionName
from gui.impl.lobby.tank_setup.backports.context_menu import TANK_SETUP_CARD_CM, TANK_SETUP_SLOT_CM, HANGAR_TANK_SETUP_SLOT_CM
from gui.Scaleform.genConsts.CONTEXT_MENU_HANDLER_TYPE import CONTEXT_MENU_HANDLER_TYPE
from gui.Scaleform.daapi.view.lobby.vehicle_preview.vehicle_preview import VEHICLE_PREVIEW_ALIASES
from halloween.gui.scaleform.genConsts.HALLOWEEN_CM_HANDLER_TYPE import HALLOWEEN_CM_HANDLER_TYPE
from halloween.gui.scaleform.genConsts.HALLOWEEN_HANGAR_ALIASES import HALLOWEEN_HANGAR_ALIASES
from gui.impl.lobby.tank_setup.backports.tooltips import PANEL_SLOT_TOOLTIPS
from halloween.gui.impl.lobby.tank_setup.backports.tooltips import HWConsumableTooltipBuilder
from gui.shared.gui_items.items_actions.factory import _ACTION_MAP
from halloween.gui.shared.gui_items.items_actions import actions
from halloween.gui.impl.lobby.tank_setup.interactor import ActionTypes
from gui.impl.lobby.tank_setup.dialogs.confirm_dialog import _SECTION_TO_FITTING_TYPE
from halloween.gui.impl.lobby.tank_setup import HWTankSetupConstants, HWFittingTypes
from gui.shared.system_factory import registerHitDirectionController, registerPrbInviteHtmlFormatter
from halloween.gui.battle_control.controllers.hit_direction_ctrl.hw_ctrl import HWHitDirectionController, HWHitDirectionControllerPlayer
from halloween.gui.game_control.award_handlers import HWArtefactAwardWindowHandler, HWDifficultyAwardWindowHandler
from gui.shared.system_factory import registerAwardControllerHandlers
from messenger.m_constants import LAZY_CHANNEL
from messenger.ext.channel_num_gen import _CHANNEL_LAZY_ORDER, _LAZY_CLIENT_IDS
from web.web_client_api.ui import OpenTabWebApi
from halloween.skeletons.halloween_controller import IHalloweenController

def _registerHWOpenTabWebApi():

    @dependency.replace_none_kwargs(ctrl=IHalloweenController)
    def _selectHalloweenMode(obj, cmd, ctrl=None):
        if ctrl and ctrl.isAvailable():
            ctrl.openHangar()

    OpenTabWebApi.addTabIdCallback('halloween2023', _selectHalloweenMode)
    return


def registerAdditionalParams(personality):
    for queueType in (QUEUE_TYPE.HALLOWEEN_MEDIUM, QUEUE_TYPE.HALLOWEEN_HARD):
        addSupportedQueues(queueType, HalloweenEntity, canSelectPrbEntity, personality)
        addQueueTypeToPrbSquadActionName(queueType, halloween_gui_constants.PREBATTLE_ACTION_NAME.HALLOWEEN_SQUAD, personality)
        addArenaGUITypeByQueueType(queueType, ARENA_GUI_TYPE.HALLOWEEN, personality)
        addQueueTypeToPrbType(queueType, PREBATTLE_TYPE.HALLOWEEN, personality)
        PREBATTLE_TYPE_TO_QUEUE_TYPE[PREBATTLE_TYPE.HALLOWEEN].append(queueType)

    TANK_SETUP_CARD_CM.update({HWTankSetupConstants.HW_CONSUMABLES: CONTEXT_MENU_HANDLER_TYPE.TANK_SETUP_CONSUMABLE_ITEM})
    TANK_SETUP_SLOT_CM.update({HWTankSetupConstants.HW_CONSUMABLES: CONTEXT_MENU_HANDLER_TYPE.TANK_SETUP_CONSUMABLE_SLOT})
    HANGAR_TANK_SETUP_SLOT_CM.update({HWTankSetupConstants.HW_CONSUMABLES: HALLOWEEN_CM_HANDLER_TYPE.TANK_SETUP_HW_HANGAR_CONSUMABLE_SLOT})
    PANEL_SLOT_TOOLTIPS.update({HWTankSetupConstants.HW_CONSUMABLES: HWConsumableTooltipBuilder})
    _ACTION_MAP.update({ActionTypes.BUY_AND_INSTALL_HW_CONSUMABLES_ACTION: actions.HWBuyAndInstallConsumables, 
       ActionTypes.BUY_AND_INSTALL_HW_DEF_CONSUMABLES_ACTION: actions.HWDefBuyAndInstallConsumables})
    _SECTION_TO_FITTING_TYPE.update({HWTankSetupConstants.HW_CONSUMABLES: HWFittingTypes.HW_EQUIPMENT})
    registerHitDirectionController(ARENA_GUI_TYPE.HALLOWEEN, HWHitDirectionController, HWHitDirectionControllerPlayer)
    registerHitDirectionController(ARENA_GUI_TYPE.HALLOWEEN_DEFENCE, HWHitDirectionController, HWHitDirectionControllerPlayer)
    registerAwardControllerHandlers((HWArtefactAwardWindowHandler, HWDifficultyAwardWindowHandler))
    registerPrbInviteHtmlFormatter(PREBATTLE_TYPE.HALLOWEEN, HalloweenPrbInviteHtmlTextFormatter)
    _registerHWOpenTabWebApi()
    VEHICLE_PREVIEW_ALIASES.update((
     HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_VEHICLE_PREVIEW, HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_HERO_PREVIEW))


def registerLazyChannelParam(extChannelConst, personality):
    extraAttrs = extChannelConst.getExtraAttrs()
    extChannelConst.inject(personality)
    for value in extraAttrs.itervalues():
        LAZY_CHANNEL.ALL += (value,)
        _CHANNEL_LAZY_ORDER.update({value: 1})

    _LAZY_CLIENT_IDS.update(dict((name, -(idx + 1 + 32)) for idx, name in enumerate(LAZY_CHANNEL.ALL)))


def initAdditionalGuiTypes(guiConstants, personality):
    registerLazyChannelParam(guiConstants.LAZY_CHANNEL, personality)