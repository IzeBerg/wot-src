from constants import ARENA_BONUS_TYPE
from gui import GUI_NATIONS_ORDER_INDEX
from gui.Scaleform.daapi.view.lobby.hangar.carousels.battle_pass.carousel_data_provider import BattlePassCarouselDataProvider
from gui.shared.gui_items.Vehicle import VEHICLE_TYPES_ORDER_INDICES

class VersusAICarouselDataProvider(BattlePassCarouselDataProvider):

    @classmethod
    def _vehicleComparisonKey(cls, vehicle):
        return (
         cls._isSuitableForQueue(vehicle),
         not vehicle.isInInventory,
         not vehicle.isEvent,
         not vehicle.isOnlyForBattleRoyaleBattles,
         not vehicle.isFavorite,
         GUI_NATIONS_ORDER_INDEX[vehicle.nationName],
         VEHICLE_TYPES_ORDER_INDICES[vehicle.type],
         vehicle.level,
         tuple(vehicle.buyPrices.itemPrice.price.iterallitems(byWeight=True)),
         vehicle.userName)

    def _getVehicleStats(self, _):
        return {}

    def _isBattlePassHidden(self, vehicle):
        return super(VersusAICarouselDataProvider, self)._isBattlePassHidden(vehicle) or not self.battlePassController.isGameModeEnabled(ARENA_BONUS_TYPE.VERSUS_AI)