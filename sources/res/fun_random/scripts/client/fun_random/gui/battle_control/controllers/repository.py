from fun_random.gui.battle_control.controllers.sound_ctrls.fun_random_battle_sounds import createFunRandomBattleSoundsController
from gui.battle_control.controllers.repositories import ClassicControllersRepository

class FunRandomControllerRepository(ClassicControllersRepository):
    __slots__ = ()

    @classmethod
    def create(cls, setup):
        repository = super(FunRandomControllerRepository, cls).create(setup)
        repository.addController(createFunRandomBattleSoundsController(setup))
        return repository