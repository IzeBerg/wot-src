import typing
from frameworks.wulf import WindowLayer
from gui.impl.gen import R
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.battle.shared.page import SharedPage
from gui.Scaleform.framework import ViewSettings, ScopeTemplates, ComponentSettings
from gui.Scaleform.framework.package_layout import PackageBusinessHandler
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from gui.app_loader import settings as app_settings
from gui.shared import EVENT_BUS_SCOPE
from helpers import dependency
from skeletons.gui.impl import IGuiLoader
if typing.TYPE_CHECKING:
    from gui.shared.events import LoadViewEvent
__all__ = ('SharedPage', )

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from gui.Scaleform.daapi.view.battle.shared import damage_info_panel
    from gui.Scaleform.daapi.view.battle.shared import debug_panel
    from gui.Scaleform.daapi.view.battle.shared import indicators
    from gui.Scaleform.daapi.view.battle.shared import ingame_help
    from gui.Scaleform.daapi.view.battle.shared import battle_loading_minimap
    from gui.Scaleform.daapi.view.battle.shared.vehicles import dualgun_component
    from gui.Scaleform.daapi.view.battle.shared import callout_panel
    from gui.Scaleform.daapi.view.battle.shared import battle_notifier
    from halloween.gui.scaleform.daapi.view.battle.shared.halloween_ingame_menu import HWIngameMenu
    from halloween.gui.scaleform.daapi.view.battle.shared.halloween_radial_menu import HalloweenRadialMenu
    return (
     ViewSettings(VIEW_ALIAS.INGAME_MENU, HWIngameMenu, 'ingameMenu.swf', WindowLayer.TOP_WINDOW, None, ScopeTemplates.DEFAULT_SCOPE, isModal=True, canClose=False, canDrag=False),
     ViewSettings(VIEW_ALIAS.INGAME_DETAILS_HELP, ingame_help.IngameDetailsHelpWindow, 'ingameDetailsHelpWindow.swf', WindowLayer.WINDOW, None, ScopeTemplates.DEFAULT_SCOPE, canClose=False, canDrag=False, isModal=True),
     ComponentSettings(BATTLE_VIEW_ALIASES.DEBUG_PANEL, debug_panel.DebugPanel, ScopeTemplates.DEFAULT_SCOPE),
     ViewSettings(BATTLE_VIEW_ALIASES.RADIAL_MENU, HalloweenRadialMenu, None, WindowLayer.UNDEFINED, None, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.DAMAGE_INFO_PANEL, damage_info_panel.DamageInfoPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.SIXTH_SENSE, indicators.SixthSenseIndicator, ScopeTemplates.DEFAULT_SCOPE),
     ViewSettings(VIEW_ALIAS.MINIMAP_ON_BATTLE_LOADING, battle_loading_minimap.BattleLoadingMinimapComponent, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.SIEGE_MODE_INDICATOR, indicators.SiegeModeIndicator, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.DUAL_GUN_PANEL, dualgun_component.DualGunComponent, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.CALLOUT_PANEL, callout_panel.CalloutPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(BATTLE_VIEW_ALIASES.BATTLE_NOTIFIER, battle_notifier.BattleNotifier, ScopeTemplates.DEFAULT_SCOPE))


def getBusinessHandlers():
    return (
     BattlePackageBusinessHandler(),)


class BattlePackageBusinessHandler(PackageBusinessHandler):
    __slots__ = ()

    def __init__(self):
        listeners = (
         (
          VIEW_ALIAS.ACOUSTIC_POPOVER, self.loadViewByCtxEvent),
         (
          VIEW_ALIAS.INGAME_MENU, self.__handleIngameMenuEvent),
         (
          VIEW_ALIAS.INGAME_HELP, self.__handleHelpEvent),
         (
          VIEW_ALIAS.INGAME_DETAILS_HELP, self.__handleHelpEvent))
        super(BattlePackageBusinessHandler, self).__init__(listeners, app_settings.APP_NAME_SPACE.SF_BATTLE, EVENT_BUS_SCOPE.BATTLE)

    def __handleIngameMenuEvent(self, event):
        window = self.findViewByAlias(WindowLayer.TOP_WINDOW, VIEW_ALIAS.INGAME_MENU)
        guiLoader = dependency.instance(IGuiLoader)
        view = guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.battle.HelpView())
        if view is not None and not view.getParentWindow().isHidden():
            return
        else:
            fullStats = guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.battle.FullStats())
            if fullStats is not None:
                return
            if window is not None:
                window.destroy()
            else:
                self.loadViewByCtxEvent(event)
            return

    def __handleHelpEvent(self, _):
        if self._app.containerManager.isModalViewsIsExists():
            return
        else:
            guiLoader = dependency.instance(IGuiLoader)
            view = guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.battle.FullStats())
            if view is not None and not view.getParentWindow().isHidden():
                return
            window = self.findViewByAlias(WindowLayer.TOP_WINDOW, VIEW_ALIAS.INGAME_MENU)
            if window is not None:
                return
            layoutID = R.views.halloween.battle.HelpView()
            view = guiLoader.windowsManager.getViewByLayoutID(layoutID)
            if view is not None:
                view.getParentWindow().destroy()
            else:
                from halloween.gui.impl.battle.help_view import HelpWindow
                HelpWindow().load()
            return

    def __isFullStatsShown(self):
        guiLoader = dependency.instance(IGuiLoader)
        return bool(guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.battle.FullStats()))