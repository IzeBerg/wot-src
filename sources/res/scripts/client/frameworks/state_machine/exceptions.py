from soft_exception import SoftException

class NodeError(SoftException):
    pass


class TransitionError(SoftException):
    pass


class StateError(SoftException):
    pass


class StateMachineError(SoftException):
    pass