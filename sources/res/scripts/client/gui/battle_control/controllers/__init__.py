import PlayerEvents
from gui.shared.system_factory import collectBattleControllerRepo
from gui.battle_control.controllers.repositories import BattleSessionSetup
from gui.battle_control.controllers.repositories import SharedControllersLocator
from gui.battle_control.controllers.repositories import DynamicControllersLocator
from gui.battle_control.controllers.repositories import ClassicControllersRepository
from gui.battle_control.controllers.repositories import SharedControllersRepository
from gui.battle_control.controllers.repositories import _ControllersRepository
__all__ = ('createShared', 'createDynamic', 'BattleSessionSetup', 'SharedControllersLocator',
           'DynamicControllersLocator', '_ControllersRepository')

def createShared(setup):
    return SharedControllersLocator(SharedControllersRepository.create(setup))


def createDynamic(setup):
    repository, inited = collectBattleControllerRepo(setup.arenaVisitor.gui.guiType, setup)
    if not inited:
        repository = ClassicControllersRepository.create(setup)
    return DynamicControllersLocator(repository=repository)