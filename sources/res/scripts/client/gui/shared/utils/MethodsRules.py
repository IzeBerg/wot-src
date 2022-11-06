import logging
from collections import defaultdict
from types import MethodType
from helpers.aop import copy
_logger = logging.getLogger(__name__)

class MethodsRules(object):

    class delayable(object):

        def __init__(self, delayerName=None):
            self.__delayerName = delayerName

        def __call__(self, listener):

            def wrapper(*args, **kwargs):
                instance = args[0]
                if instance.delay(self.__delayerName, listener, *args, **kwargs):
                    return
                result = listener(*args, **kwargs)
                instance.processDelayer(listener.__name__)
                return result

            copy(wrapper, listener)
            return wrapper

        def __get__(self, obj, objtype=None):
            return MethodType(self, obj, objtype)

    def __init__(self):
        super(MethodsRules, self).__init__()
        self.__listenersToSkip = []
        self.__notificationToDelay = defaultdict(list)
        self.__delayersProcessed = set()

    def clear(self, reset=True):
        self.__listenersToSkip = []
        self.__delayersProcessed.clear()
        if reset:
            self.__notificationToDelay.clear()

    def skipListenerNotification(self, wrapper):
        self.__listenersToSkip.append(wrapper.listener)

    def isSkipable(self, listener):
        return listener in self.__listenersToSkip

    def isDelayerProcessed(self, delayerName):
        return delayerName in self.__delayersProcessed

    def skip(self, listener):
        if self.isSkipable(listener):
            self.__listenersToSkip.remove(listener)
            return True
        return False

    def delay(self, delayerName, notification, *args, **kwargs):
        if delayerName is not None and not self.isDelayerProcessed(delayerName):
            self.__notificationToDelay[delayerName].append((notification, args, kwargs))
            return True
        else:
            return False

    def processDelayer(self, delayerName):
        _logger.debug('Delayer processed: %r', delayerName)
        self.__delayersProcessed.add(delayerName)
        pending = self.__notificationToDelay.pop(delayerName, ())
        delayers = set()
        for notification, args, kwargs in pending:
            _logger.debug('Notification processed: %r, %r, %r', notification, args, kwargs)
            notification(*args, **kwargs)
            delayers.add(notification.__name__)

        for delayer in delayers:
            self.processDelayer(delayer)