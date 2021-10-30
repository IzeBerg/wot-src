import typing
from gui.Scaleform.daapi.view.lobby.vehicle_preview.vehicle_preview import VehiclePreview
from gui.Scaleform.genConsts.VEHPREVIEW_CONSTANTS import VEHPREVIEW_CONSTANTS
from gui.server_events.events_dispatcher import showMissionsMarathon
from helpers import dependency
from skeletons.gui.game_control import IMarathonEventsController
from gui.impl import backport
from gui.impl.gen import R
from web.web_client_api.common import ItemPackTypeGroup

class MarathonVehiclePreview(VehiclePreview):
    __marathonCtrl = dependency.descriptor(IMarathonEventsController)

    def __init__(self, ctx=None):
        super(MarathonVehiclePreview, self).__init__(ctx)
        self.__marathonPrefix = ctx.get('marathonPrefix')
        self.__marathon = self.__marathonCtrl.getMarathon(self.__marathonPrefix)

    def _onRegisterFlashComponent(self, viewPy, alias):
        if alias == VEHPREVIEW_CONSTANTS.BUYING_PANEL_PY_ALIAS:
            if self._itemsPack:
                viewPy.setMarathonEvent(self.__marathonPrefix)
                viewPy.setInfoTooltip()
                viewPy.setPackItems(self._itemsPack, self._price, self._oldPrice, self._title)
        elif alias == VEHPREVIEW_CONSTANTS.CREW_LINKAGE:
            if self._itemsPack:
                crewItems = tuple(item for item in self._itemsPack if item.type in ItemPackTypeGroup.CREW)
                vehicleItems = tuple(item for item in self._itemsPack if item.type in ItemPackTypeGroup.VEHICLE)
                viewPy.setVehicleCrews(vehicleItems, crewItems)

    def _processBackClick(self, ctx=None):
        showMissionsMarathon(self.__marathonPrefix)

    def _getBackBtnLabel(self):
        if self.__marathon is None:
            return backport.text(R.strings.vehicle_preview.header.backBtn.descrLabel.marathon())
        else:
            return backport.text(self.__marathon.backBtnLabel)

    def _getExitEvent(self):
        exitEvent = super(MarathonVehiclePreview, self)._getExitEvent()
        exitEvent.ctx.update({'marathonPrefix': self.__marathonPrefix})
        return exitEvent