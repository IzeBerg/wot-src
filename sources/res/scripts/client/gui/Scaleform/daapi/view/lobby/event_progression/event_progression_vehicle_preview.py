import typing
from CurrentVehicle import g_currentPreviewVehicle
from gui.Scaleform.daapi.view.lobby.vehicle_preview.items_kit_helper import getDataOneVehicle, addBuiltInEquipment
from gui.Scaleform.daapi.view.lobby.vehicle_preview.vehicle_preview import VehiclePreview
from gui.Scaleform.genConsts.VEHPREVIEW_CONSTANTS import VEHPREVIEW_CONSTANTS
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.shared.formatters import text_styles, icons
from helpers import dependency
from skeletons.gui.game_control import IEventProgressionController
from web.web_client_api.common import ItemPackEntry, ItemPackType
from gui.shared.utils.functions import makeTooltip
from gui.impl import backport
from gui.impl.gen import R

class EventProgressionVehiclePreview(VehiclePreview):
    __eventProgression = dependency.descriptor(IEventProgressionController)

    def __init__(self, ctx=None):
        super(EventProgressionVehiclePreview, self).__init__(ctx)
        self._heroInteractive = False
        self.__itemsPack = [
         ItemPackEntry(type=ItemPackType.CREW_100, count=1, groupID=1),
         ItemPackEntry(type=ItemPackType.CUSTOM_SLOT, count=1, groupID=1)]
        addBuiltInEquipment(self.__itemsPack, self.itemsCache, self._vehicleCD)

    def _onRegisterFlashComponent(self, viewPy, alias):
        super(EventProgressionVehiclePreview, self)._onRegisterFlashComponent(viewPy, alias)
        if alias == VEHPREVIEW_CONSTANTS.EVENT_PROGRESSION_VEHICLE_BUYING_PANEL_PY_ALIAS:
            itemsData = getDataOneVehicle(itemsPack=self.__itemsPack, vehicle=g_currentPreviewVehicle.item, vehicleGroupId=1)
            itemsData.insert(0, self.__getDefaultCrewItemPackEntry())
            viewPy.setData(self._getBuyingPanelData(), itemsPack=self.__itemsPack, packedItemsVO={'items': itemsData})
        elif alias == VEHPREVIEW_CONSTANTS.CREW_LINKAGE:
            viewPy.setVehicleCrews((
             ItemPackEntry(id=g_currentPreviewVehicle.item.intCD, groupID=1),), (
             ItemPackEntry(type=ItemPackType.CREW_100, groupID=1),))

    def _getBuyingPanelData(self):
        vehiclePrice = self.__eventProgression.getRewardVehiclePrice(g_currentPreviewVehicle.item.intCD)
        storedPoints = self.__eventProgression.actualRewardPoints
        haveEnoughPoints = 0 < storedPoints >= vehiclePrice
        if not haveEnoughPoints:
            resID = R.strings.tooltips.vehiclePreview.buyButton.notEnoughPrestigePoints
            buyButtonTooltip = makeTooltip(body=backport.text(resID.header(), points=vehiclePrice))
        else:
            buyButtonTooltip = ''
        formatMoney = text_styles.superPromoTitleEm if storedPoints > 0 else text_styles.superPromoTitleErr
        formatPrice = text_styles.superPromoTitleEm if haveEnoughPoints else text_styles.superPromoTitleErr
        tokensIcon = icons.makeImageTag(source=backport.image(R.images.gui.maps.icons.epicBattles.rewardPoints.c_32x32()), width=32, height=32, vSpace=-6, hSpace=3)

        def formatTitle(rID):
            return text_styles.superPromoTitle(backport.text(rID()))

        return {'title': formatTitle(R.strings.event_progression.vehicle_preview.title), 
           'shortTitle': formatTitle(R.strings.event_progression.vehicle_preview.title.short), 
           'money': text_styles.concatStylesToSingleLine(formatMoney(str(storedPoints)), tokensIcon), 
           'price': text_styles.concatStylesToSingleLine(formatPrice(str(vehiclePrice)), tokensIcon), 
           'priceTooltip': TOOLTIPS.VEHICLEPREVIEW_BUYINGPANEL_EVENTPROGRESSION_PRICE, 
           'buyButtonEnabled': haveEnoughPoints and not buyButtonTooltip, 
           'buyButtonLabel': backport.text(R.strings.vehicle_preview.buyingPanel.buyBtn.label.buy()), 
           'buyButtonTooltip': buyButtonTooltip}

    def setBottomPanel(self):
        self.as_setBottomPanelS(VEHPREVIEW_CONSTANTS.EVENT_PROGRESSION_VEHICLE_BUYING_PANEL_LINKAGE)

    def _processBackClick(self, ctx=None):
        self.__eventProgression.openURL(self._backAlias)

    def _getBackBtnLabel(self):
        return ''

    @classmethod
    def __getDefaultCrewItemPackEntry(cls):
        return {'isEnabled': True, 
           'topTitle': '', 
           'topTitleSmall': '', 
           'items': [
                   {'count': '100%', 
                      'hasCompensation': False, 
                      'icon': backport.image(R.images.gui.maps.shop.rewards.c_48x48.prizeCrew()), 
                      'iconAlt': backport.image(R.images.gui.maps.icons.artefact.notFound()), 
                      'id': 'None', 
                      'overlayType': '', 
                      'rawData': None, 
                      'slotIndex': 0, 
                      'type': ItemPackType.CREW_100}]}