import BigWorld
from CurrentVehicle import g_currentPreviewVehicle
from gui.Scaleform.daapi.view.lobby.vehicle_preview.vehicle_preview import VehiclePreview
from gui.Scaleform.daapi.view.meta.VehiclePreviewBottomPanelWotPlusMeta import VehiclePreviewBottomPanelWotPlusMeta
from gui.Scaleform.genConsts.VEHPREVIEW_CONSTANTS import VEHPREVIEW_CONSTANTS
from gui.impl import backport
from gui.impl.gen import R
import wg_async as future_async
from gui.Scaleform.daapi.view.lobby.event_boards.formaters import formatDate
from gui.shared.event_dispatcher import showWotPlusRentDialog
from gui.shared.gui_items.Vehicle import getIconResourceName, getNationLessName
from gui.shop import showRentProductOverlay
from helpers import dependency
from skeletons.gui.game_control import IWotPlusController

class WotPlusVehiclePreview(VehiclePreview):

    def setBottomPanel(self):
        self.as_setBottomPanelS(VEHPREVIEW_CONSTANTS.BOTTOM_PANEL_WOT_PLUS_LINKAGE)


class VehiclePreviewBottomPanelWotPlus(VehiclePreviewBottomPanelWotPlusMeta):
    _wotPlusCtrl = dependency.descriptor(IWotPlusController)

    def _populate(self):
        super(VehiclePreviewBottomPanelWotPlus, self)._populate()
        self.as_setDataS({'rentButtonLabel': backport.text(R.strings.subscription.rentButton.label()), 
           'isRentButtonEnable': True})

    def onRentClick(self):
        self.__purchaseSubRent()

    def setOffers(self, offers):
        self.__buyParams = offers[0].buyParams

    @future_async.wg_async
    def __purchaseSubRent(self):

        def successCallback():
            showRentProductOverlay(self.__buyParams)

        title = backport.text(R.strings.dialogs.wotPlusRental.title())
        vehicleName = g_currentPreviewVehicle.item.userName
        vehicleName = vehicleName.replace('(', '%((')
        vehicleName = vehicleName.replace(')', '))')
        title %= vehicleName
        date = formatDate(self._wotPlusCtrl.getExpiryTime())
        if 'event_type' in self.__buyParams and self.__buyParams['event_type'] == 'telecom_rentals':
            date = formatDate(BigWorld.player().telecomRentals.getRosterExpirationTime())
        description = backport.text(R.strings.dialogs.wotPlusRental.description()) % date
        iconName = getIconResourceName(getNationLessName(g_currentPreviewVehicle.item.name))
        icon = R.images.gui.maps.shop.vehicles.c_360x270.dyn(iconName)()
        yield future_async.wg_await(showWotPlusRentDialog(title, description, icon, successCallback))