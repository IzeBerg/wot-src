from bootcamp.states import STATE
from bootcamp.states.AbstractState import AbstractState

class StateInitial(AbstractState):

    def __init__(self):
        super(StateInitial, self).__init__(STATE.INITIAL)

    def handleKeyEvent(self, event):
        pass

    def _doActivate(self):
        pass

    def _doDeactivate(self):
        pass