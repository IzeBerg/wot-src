from chat_commands_consts import MarkerType
from gui.Scaleform.daapi.view.battle.shared.component_marker.markers_components import MinimapMarkerComponent, StaticDeathZoneMinimapMarkerComponent
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from halloween.gui.scaleform.daapi.view.battle.markers2d.markers_components import getSoulsCollectorMarkerState
import SoundGroups
from gui.Scaleform.daapi.view.battle.epic.minimap import MINIMAP_SCALE_TYPES
from gui.Scaleform.daapi.view.battle.shared.minimap import settings
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class CampMinimapMarkerComponent(MinimapMarkerComponent):

    @property
    def bcMarkerType(self):
        return MarkerType.TARGET_POINT_MARKER_TYPE

    def _createMarker(self, **kwargs):
        gui = self._gui()
        if gui and not self._isMarkerExists:
            matrix = self._translationOnlyMP if self._onlyTranslation else self._matrixProduct.a
            self._isMarkerExists = gui.createMarker(self._componentID, self._config['symbol'], self._config['container'], matrix=matrix, active=self._isVisible, targetID=self._targetID, bcMarkerType=self.bcMarkerType)
            if self._isMarkerExists:
                self._setupMarker(gui)

    def _setupMarker(self, gui, **kwargs):
        super(CampMinimapMarkerComponent, self)._setupMarker(gui)
        gui.setHasAnimation(self._componentID, True)
        gui.setEntryParameters(self._componentID, doClip=False, scaleType=MINIMAP_SCALE_TYPES.PROPORTIONAL)


class SoulsCollectorMinimapMarkerComponent(CampMinimapMarkerComponent):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    @property
    def hwBattleGuiCtrl(self):
        return self.__sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    def _deleteMarker(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress -= self._updateMarkerState
        super(SoulsCollectorMinimapMarkerComponent, self)._deleteMarker()

    def _setupMarker(self, gui, **kwargs):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress += self._updateMarkerState
        if self._entity and 'hwSoulsCollector' in self._entity.dynamicComponents:
            soulsComponent = self._entity.hwSoulsCollector
            self._updateMarkerState(soulsComponent.collected, soulsComponent.capacity, soulsComponent.isFull)

    def _updateMarkerState(self, collected, capacity, isFull):
        gui = self._gui()
        if gui and self._isMarkerExists:
            gui.invoke(self.componentID, 'setVolotState', getSoulsCollectorMarkerState(isFull))


class BotSpawnNotificationMarkerComponent(MinimapMarkerComponent):
    _ANIMATION_NAME = 'firstEnemy'
    _GUI_PROPS_NAME = 'enemy'

    def _setupMarker(self, gui, **kwargs):
        super(BotSpawnNotificationMarkerComponent, self)._setupMarker(gui)
        gui.invoke(self.componentID, 'setVehicleInfo', '', '', '', self._GUI_PROPS_NAME, self._ANIMATION_NAME)
        SoundGroups.g_instance.playSound2D(settings.MINIMAP_ATTENTION_SOUND_ID)


class HWStaticDeathZoneMinimapMarkerComponent(StaticDeathZoneMinimapMarkerComponent):
    _MINIMAP_1M_IN_PX = 0.21

    def _setupMarker(self, gui, **kwargs):
        super(HWStaticDeathZoneMinimapMarkerComponent, self)._setupMarker(gui)
        gui.setEntryParameters(self._componentID, doClip=False, scaleType=MINIMAP_SCALE_TYPES.REAL_SCALE)

    def _getSize(self):
        xc = yc = self._MINIMAP_1M_IN_PX * 2
        return (xc, yc)