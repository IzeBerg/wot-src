from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.carousel_data_provider import HangarCarouselDataProvider
from gui.shared.utils.requesters import REQ_CRITERIA

class EventBattleCarouselDataProvider(HangarCarouselDataProvider):

    def _setBaseCriteria(self):
        self._baseCriteria = REQ_CRITERIA.INVENTORY | REQ_CRITERIA.VEHICLE.EVENT_BATTLE