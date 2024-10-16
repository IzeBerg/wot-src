from gui.prebattle_hints.controller import PrebattleHintsController
from gui.prebattle_hints.newbie_controller import NewbiePrebattleHintsController
from skeletons.gui.prebattle_hints.controller import IPrebattleHintsController
from skeletons.gui.prebattle_hints.newbie_controller import INewbiePrebattleHintsController

def controllersConfig(manager):
    manager.addInstance(IPrebattleHintsController, PrebattleHintsController(), finalizer='fini')
    manager.addInstance(INewbiePrebattleHintsController, NewbiePrebattleHintsController(), finalizer='fini')