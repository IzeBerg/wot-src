import BigWorld
from HeroTank import HeroTank
from gui.Scaleform.daapi.view.lobby.vehicle_preview.vehicle_preview import VehiclePreview
from gui.Scaleform.genConsts.VEHPREVIEW_CONSTANTS import VEHPREVIEW_CONSTANTS
from gui.hangar_cameras.hangar_camera_common import CameraMovementStates
from gui.prb_control.entities.listener import IGlobalListener
from halloween.gui.scaleform.genConsts.HALLOWEEN_HANGAR_ALIASES import HALLOWEEN_HANGAR_ALIASES
from halloween.gui.shared.event_dispatcher import showVehiclePreview, showHeroTankPreview, showHangar
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import HW_PREVIEW_ENTER, HW_PREVIEW_EXIT, HANGAR_SOUND_SETTINGS

class HWVehiclePreview(VehiclePreview, IGlobalListener):
    _COMMON_SOUND_SPACE = HANGAR_SOUND_SETTINGS

    def __init__(self, ctx=None):
        self.__ctx = ctx
        self.__isHandledClick = False
        super(HWVehiclePreview, self).__init__(ctx)

    def setBottomPanel(self):
        if self.__ctx.get('isKingReward') or self.__ctx.get('isHeroTank'):
            self.as_setBottomPanelS(VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_LINKAGE)

    def closeView(self):
        self.__isHandledClick = True
        showHangar()

    def handleSelectedEntityUpdated(self, event):
        ctx = event.ctx
        entity = BigWorld.entities.get(ctx['entityId'], None)
        if ctx['state'] == CameraMovementStates.MOVING_TO_OBJECT:
            if isinstance(entity, HeroTank):
                descriptor = entity.typeDescriptor
                if descriptor:
                    vehicleCD = descriptor.type.compactDescr
                    showHeroTankPreview(vehicleCD, previewAlias=HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_VEHICLE_PREVIEW, backOutfit=self.__ctx.get('outfit'), previewBackCb=self.__ctx.get('previewBackCb'), backBtnLabel=self.__ctx.get('backBtnLabel', ''), isHiddenMenu=True, isKingReward=self.__ctx.get('isKingReward', False))
            elif entity.id == self._hangarSpace.space.vehicleEntityId and not self.__isHandledClick:
                self._processBackClick({'entity': entity})
        return

    def onPrbEntitySwitched(self):
        self.__isHandledClick = True

    def _populate(self):
        super(HWVehiclePreview, self)._populate()
        playSound(HW_PREVIEW_ENTER)
        self.startGlobalListening()

    def _dispose(self):
        self.stopGlobalListening()
        playSound(HW_PREVIEW_EXIT)
        super(HWVehiclePreview, self)._dispose()

    def _processBackClick(self, ctx=None):
        entity = ctx.get('entity', None) if ctx else None
        if self._previewBackCb and not entity:
            self._previewBackCb()
            self.__isHandledClick = True
        elif self._backAlias == HALLOWEEN_HANGAR_ALIASES.HALLOWEEN_VEHICLE_PREVIEW:
            if entity:
                compactDescr = entity.typeDescriptor.type.compactDescr
                showVehiclePreview(itemCD=compactDescr, previewAlias=self.__ctx.get('previousBackAlias'), outfit=self.__ctx.get('backOutfit'), backBtnLabel=self.__ctx.get('backBtnLabel', ''), previewBackCb=self.__ctx.get('previewBackCb'), isKingReward=self.__ctx.get('isKingReward', False))
        else:
            super(HWVehiclePreview, self)._processBackClick(ctx)
        return