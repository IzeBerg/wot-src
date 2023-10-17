from chat_commands_consts import MarkerType
from gui.Scaleform.daapi.view.battle.shared.component_marker.markers_components import MinimapMarkerComponent, StaticDeathZoneMinimapMarkerComponent
from halloween.gui.scaleform.daapi.view.battle.markers2d.markers_components import getSoulsCollectorMarkerState
import SoundGroups
from gui.Scaleform.daapi.view.battle.epic.minimap import MINIMAP_SCALE_TYPES
from gui.Scaleform.daapi.view.battle.shared.minimap import settings

class CampMinimapMarkerComponent(MinimapMarkerComponent):

    @property
    def bcMarkerType(self):
        return MarkerType.TARGET_POINT_MARKER_TYPE

    def _createMarker(self):
        gui = self._gui()
        if gui and not self._isMarkerExists:
            matrix = self._translationOnlyMP if self._onlyTranslation else self._matrixProduct.a
            self._isMarkerExists = gui.createMarker(self._componentID, self._config['symbol'], self._config['container'], matrix=matrix, active=self._isVisible, targetID=self._targetID, bcMarkerType=self.bcMarkerType)
            if self._isMarkerExists:
                self._setupMarker(gui)

    def _setupMarker(self, gui):
        super(CampMinimapMarkerComponent, self)._setupMarker(gui)
        gui.setHasAnimation(self._componentID, True)
        gui.setEntryParameters(self._componentID, doClip=False, scaleType=MINIMAP_SCALE_TYPES.PROPORTIONAL)


class SoulsCollectorMinimapMarkerComponent(CampMinimapMarkerComponent):

    def _deleteMarker(self):
        if self._entity and 'hwSoulsCollector' in self._entity.dynamicComponents:
            self._entity.hwSoulsCollector.onUpdateSoulsCollectorState -= self._updateMarkerState
        super(SoulsCollectorMinimapMarkerComponent, self)._deleteMarker()

    def _setupMarker(self, gui):
        if self._entity and 'hwSoulsCollector' in self._entity.dynamicComponents:
            soulsComponent = self._entity.hwSoulsCollector
            soulsComponent.onUpdateSoulsCollectorState += self._updateMarkerState
            self._updateMarkerState(soulsComponent.collected, soulsComponent.capacity, soulsComponent.isFull, soulsComponent.vehicleStats.getTeamSouls() if soulsComponent.vehicleStats else 0)

    def _updateMarkerState(self, collected, capacity, isFull, teamSouls):
        gui = self._gui()
        if gui and self._isMarkerExists:
            gui.invoke(self.componentID, 'setVolotState', getSoulsCollectorMarkerState(collected, capacity, isFull, teamSouls))


class BotSpawnNotificationMarkerComponent(MinimapMarkerComponent):
    _ANIMATION_NAME = 'firstEnemy'

    def _setupMarker(self, gui):
        super(BotSpawnNotificationMarkerComponent, self)._setupMarker(gui)
        gui.invoke(self.componentID, 'setVehicleInfo', '', '', '', '', self._ANIMATION_NAME)
        SoundGroups.g_instance.playSound2D(settings.MINIMAP_ATTENTION_SOUND_ID)


class HWStaticDeathZoneMinimapMarkerComponent(StaticDeathZoneMinimapMarkerComponent):
    _MINIMAP_1M_IN_PX = 0.21

    def _setupMarker(self, gui):
        super(HWStaticDeathZoneMinimapMarkerComponent, self)._setupMarker(gui)
        gui.setEntryParameters(self._componentID, doClip=False, scaleType=MINIMAP_SCALE_TYPES.REAL_SCALE)

    def _getSize(self):
        xc = yc = self._MINIMAP_1M_IN_PX * 2
        return (xc, yc)