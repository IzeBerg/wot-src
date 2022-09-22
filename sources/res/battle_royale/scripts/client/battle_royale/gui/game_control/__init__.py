from battle_royale.gui.game_control.battle_royale_controller import BattleRoyaleController as _BattleRoyale
from battle_royale.gui.game_control.battle_royale_tournament_controller import BattleRoyaleTournamentController as _BRTournament
from battle_royale.gui.game_control.battle_royale_rent_vehicles_controller import BattleRoyaleRentVehiclesController as _BRRentController
import skeletons.gui.game_control as _interface
from gui.shared.system_factory import registerGameControllers

def registerBRGameControllers():
    registerGameControllers([(_interface.IBattleRoyaleController, _BattleRoyale),
     (
      _interface.IBattleRoyaleTournamentController, _BRTournament),
     (
      _interface.IBattleRoyaleRentVehiclesController, _BRRentController)])