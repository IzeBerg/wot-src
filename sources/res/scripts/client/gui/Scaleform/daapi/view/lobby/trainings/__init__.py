from frameworks.wulf import WindowLayer
from gui.Scaleform.framework import ViewSettings
from gui.Scaleform.framework import GroupedViewSettings, ScopeTemplates
from gui.Scaleform.framework.package_layout import PackageBusinessHandler
from gui.Scaleform.genConsts.PREBATTLE_ALIASES import PREBATTLE_ALIASES
from gui.app_loader import settings as app_settings
from gui.shared import EVENT_BUS_SCOPE

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from gui.Scaleform.daapi.view.lobby.trainings.Trainings import Trainings
    from gui.Scaleform.daapi.view.lobby.trainings.training_room import TrainingRoom
    from gui.Scaleform.daapi.view.lobby.trainings.TrainingSettingsWindow import TrainingSettingsWindow
    return (
     ViewSettings(PREBATTLE_ALIASES.TRAINING_LIST_VIEW_PY, Trainings, 'trainingForm.swf', WindowLayer.SUB_VIEW, PREBATTLE_ALIASES.TRAINING_LIST_VIEW_PY, ScopeTemplates.LOBBY_SUB_SCOPE, True),
     ViewSettings(PREBATTLE_ALIASES.TRAINING_ROOM_VIEW_PY, TrainingRoom, 'trainingRoom.swf', WindowLayer.SUB_VIEW, PREBATTLE_ALIASES.TRAINING_ROOM_VIEW_PY, ScopeTemplates.DEFAULT_SCOPE, True),
     GroupedViewSettings(PREBATTLE_ALIASES.TRAINING_SETTINGS_WINDOW_PY, TrainingSettingsWindow, 'trainingWindow.swf', WindowLayer.WINDOW, PREBATTLE_ALIASES.TRAINING_SETTINGS_WINDOW_PY, None, ScopeTemplates.DEFAULT_SCOPE, True))


def getBusinessHandlers():
    return (
     _TrainingPackageBusinessHandler(),)


class _TrainingPackageBusinessHandler(PackageBusinessHandler):

    def __init__(self):
        listeners = (
         (
          PREBATTLE_ALIASES.TRAINING_LIST_VIEW_PY, self.loadViewByCtxEvent),
         (
          PREBATTLE_ALIASES.TRAINING_ROOM_VIEW_PY, self.loadViewByCtxEvent),
         (
          PREBATTLE_ALIASES.TRAINING_SETTINGS_WINDOW_PY, self.loadViewByCtxEvent))
        super(_TrainingPackageBusinessHandler, self).__init__(listeners, app_settings.APP_NAME_SPACE.SF_LOBBY, EVENT_BUS_SCOPE.LOBBY)