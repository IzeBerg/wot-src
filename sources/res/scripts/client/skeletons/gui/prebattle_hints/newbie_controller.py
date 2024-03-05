from skeletons.gui.prebattle_hints.controller import IPrebattleHintsControlStrategy

class INewbiePrebattleHintsController(IPrebattleHintsControlStrategy):

    def fini(self):
        raise NotImplementedError

    def isEnabled(self):
        raise NotImplementedError

    def onConfirmationWindowShown(self):
        raise NotImplementedError