from debug_utils import LOG_ERROR
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.battle.epic import EpicBattlePageBusinessHandler
from gui.Scaleform.daapi.view.battle.shared.page import BattlePageBusinessHandler
from gui.Scaleform.framework import ComponentSettings
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.Scaleform.framework import ScopeTemplates

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from frontline.gui.Scaleform.daapi.view.battle.battle_upgrade_panel import EpicBattleUpgradePanel
    return (
     ComponentSettings(BATTLE_VIEW_ALIASES.UPGRADE_PANEL, EpicBattleUpgradePanel, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return (
     BattlePageBusinessHandler(VIEW_ALIAS.EPIC_BATTLE_PAGE), EpicBattlePageBusinessHandler())