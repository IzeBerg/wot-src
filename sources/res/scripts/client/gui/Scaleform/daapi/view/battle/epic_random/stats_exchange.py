from gui.Scaleform.daapi.view.battle.classic.stats_exchange import ClassicStatisticsDataController, DynamicVehicleStatsComponent
from gui.Scaleform.daapi.view.battle.shared.stats_exchange import createExchangeBroker
from gui.Scaleform.daapi.view.battle.shared.stats_exchange import broker
from gui.Scaleform.daapi.view.battle.shared.stats_exchange import vehicle
from gui.battle_control.arena_info.arena_vos import EPIC_RANDOM_KEYS

class EpicRandomVehicleInfoComponent(vehicle.VehicleInfoComponent):

    def addVehicleInfo(self, vInfoVO, overrides):
        super(EpicRandomVehicleInfoComponent, self).addVehicleInfo(vInfoVO, overrides)
        return self._data.update({'playerGroup': vInfoVO.gameModeSpecific.getValue(EPIC_RANDOM_KEYS.PLAYER_GROUP)})


class EpicRandomStatisticsDataController(ClassicStatisticsDataController):

    def _createExchangeBroker(self, exchangeCtx):
        exchangeBroker = createExchangeBroker(exchangeCtx)
        exchangeBroker.setVehiclesInfoExchange(vehicle.VehiclesExchangeBlock(EpicRandomVehicleInfoComponent(), positionComposer=broker.BiDirectionComposer(), idsComposers=(
         vehicle.TeamsSortedIDsComposer(),
         vehicle.TeamsCorrelationIDsComposer()), statsComposers=None))
        exchangeBroker.setVehiclesStatsExchange(vehicle.VehiclesExchangeBlock(DynamicVehicleStatsComponent(), positionComposer=broker.BiDirectionComposer(), idsComposers=None, statsComposers=(
         vehicle.TotalStatsComposer(),)))
        exchangeBroker.setVehicleStatusExchange(vehicle.VehicleStatusComponent(idsComposers=(
         vehicle.TeamsSortedIDsComposer(),
         vehicle.TeamsCorrelationIDsComposer()), statsComposers=(
         vehicle.TotalStatsComposer(),)))
        return exchangeBroker