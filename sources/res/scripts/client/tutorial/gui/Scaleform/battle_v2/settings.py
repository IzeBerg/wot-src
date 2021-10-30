from frameworks.wulf import WindowLayer
from gui.Scaleform.framework import GroupedViewSettings, ScopeTemplates
from tutorial.gui.Scaleform.battle_v2.pop_ups import ReplenishAmmoDialog

class BATTLE_VIEW_ALIAS(object):
    REPLENISH_AMMO_DIALOG = 'replenishAmmoDialog'


BATTLE_VIEW_SETTINGS = (
 GroupedViewSettings(BATTLE_VIEW_ALIAS.REPLENISH_AMMO_DIALOG, ReplenishAmmoDialog, 'replenishAmmoDialog.swf', WindowLayer.TOP_WINDOW, '', None, ScopeTemplates.DEFAULT_SCOPE, isModal=True, canClose=False, isCentered=False),)
DIALOG_ALIAS_MAP = {'replenishAmmo': BATTLE_VIEW_ALIAS.REPLENISH_AMMO_DIALOG}