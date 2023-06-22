from functools import wraps
import operator

def autoCooldown(method):

    @wraps(method)
    def wrapper(burstPredictor, *args, **kwargs):
        if burstPredictor.isShootingPossible():
            return method(burstPredictor, *args, **kwargs)
        burstPredictor.activateCooldown()

    return wrapper


def checkPredictionStates(states=(), defReturn=None, abortAction=None):

    def decorator(method):

        @wraps(method)
        def wrapper(burstPredictor, *args, **kwargs):
            if burstPredictor.getPredictionState() in states:
                return method(burstPredictor, *args, **kwargs)
            else:
                if abortAction is not None:
                    return operator.methodcaller(abortAction)(burstPredictor)
                return defReturn

        return wrapper

    return decorator


def checkStateStatus(states=(), defReturn=None, abortAction=None):

    def decorator(method):

        @wraps(method)
        def wrapper(controller, *args, **kwargs):
            stateStatus = controller.stateStatus
            if stateStatus is not None and stateStatus.state in states:
                return method(controller, stateStatus, *args, **kwargs)
            else:
                if abortAction is not None:
                    return operator.methodcaller(abortAction)(controller)
                return defReturn

        return wrapper

    return decorator