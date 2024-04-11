from gui.battle_control.controllers.repositories import ClassicControllersRepository
from historical_battles.gui.shared import battle_hints
from historical_battles.gui.battle_control.controllers.appearance_cache_controller import HBAppearanceCacheController

class HBControllersRepository(ClassicControllersRepository):

    @classmethod
    def create(cls, setup):
        repository = super(HBControllersRepository, cls).create(setup)
        repository.addViewController(battle_hints.createBattleHintsController(), setup)
        return repository

    @staticmethod
    def _getAppearanceCacheController(setup):
        return HBAppearanceCacheController(setup)