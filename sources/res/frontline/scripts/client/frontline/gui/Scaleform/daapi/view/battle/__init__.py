from frontline.gui.Scaleform.daapi.view.battle.consumables_panel import EpicBattleConsumablesPanel
from frontline.gui.Scaleform.daapi.view.battle.pre_battle_timer import EpicPreBattleTimer
from gui.Scaleform.framework import ComponentSettings
from gui.Scaleform.framework import ScopeTemplates
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from frontline.gui.Scaleform.daapi.view.battle.battle_upgrade_panel import EpicBattleUpgradePanel
    from frontline.gui.Scaleform.daapi.view.battle.battle_modification_panel import EpicBattleModificationPanel
    return (
     ComponentSettings(BATTLE_VIEW_ALIASES.UPGRADE_PANEL, EpicBattleUpgradePanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.EPIC_MODIFICATION_PANEL, EpicBattleModificationPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.PREBATTLE_TIMER, EpicPreBattleTimer, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL, EpicBattleConsumablesPanel, ScopeTemplates.DEFAULT_SCOPE))


def getBusinessHandlers():
    return ()