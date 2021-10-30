from gui.Scaleform.daapi.view.battle.shared.markers2d import MarkersManager
from gui.Scaleform.daapi.view.battle.event.plugins import EventVehicleMarkerPlugin, EventCampsOrControlsPointsPlugin, EventEquipmentsMarkerPlugin
from account_helpers.settings_core.settings_constants import BattleCommStorageKeys

class EventMarkersManager(MarkersManager):

    def _populate(self):
        self.settingsCore.applySetting(BattleCommStorageKeys.SHOW_STICKY_MARKERS, True)
        self.settingsCore.applySetting(BattleCommStorageKeys.SHOW_BASE_MARKERS, True)
        self.settingsCore.confirmChanges(self.settingsCore.applyStorages(restartApproved=False))
        self.settingsCore.clearStorages()
        super(EventMarkersManager, self)._populate()

    def _setupPlugins(self, arenaVisitor):
        setup = super(EventMarkersManager, self)._setupPlugins(arenaVisitor)
        setup['vehicles'] = EventVehicleMarkerPlugin
        setup['teamAndControlPoints'] = EventCampsOrControlsPointsPlugin
        setup['equipments'] = EventEquipmentsMarkerPlugin
        return setup