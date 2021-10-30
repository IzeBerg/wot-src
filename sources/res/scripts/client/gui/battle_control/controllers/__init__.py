from gui.battle_control.controllers.repositories import BattleSessionSetup
from gui.battle_control.controllers.repositories import SharedControllersLocator
from gui.battle_control.controllers.repositories import DynamicControllersLocator
from gui.battle_control.controllers.repositories import ClassicControllersRepository
from gui.battle_control.controllers.repositories import EpicControllersRepository
from gui.battle_control.controllers.repositories import EventControllersRepository
from gui.battle_control.controllers.repositories import SharedControllersRepository
from gui.battle_control.controllers.repositories import BattleRoyaleControllersRepository
from gui.battle_control.controllers.repositories import MapsTrainingControllerRepository
__all__ = ('createShared', 'createDynamic', 'BattleSessionSetup', 'SharedControllersLocator',
           'DynamicControllersLocator')

def createShared(setup):
    return SharedControllersLocator(SharedControllersRepository.create(setup))


def createDynamic(setup):
    guiVisitor = setup.arenaVisitor.gui
    if guiVisitor.isInEpicRange():
        repository = EpicControllersRepository.create(setup)
    elif guiVisitor.isBattleRoyale():
        repository = BattleRoyaleControllersRepository.create(setup)
    elif guiVisitor.isEventBattle():
        repository = EventControllersRepository.create(setup)
    elif guiVisitor.isMapsTraining():
        repository = MapsTrainingControllerRepository.create(setup)
    elif not guiVisitor.isTutorialBattle():
        repository = ClassicControllersRepository.create(setup)
    else:
        repository = None
    return DynamicControllersLocator(repository=repository)