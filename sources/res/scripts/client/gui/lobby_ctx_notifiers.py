from collections import namedtuple
from gui import SystemMessages
from gui.impl import backport
from gui.shared.notifications import NotificationPriorityLevel
NotifySysMessages = namedtuple('NotifySysMessages', 'resID, priority, type')
NotifySysMessages.__new__.__defaults__ = (
 None, NotificationPriorityLevel.MEDIUM, SystemMessages.SM_TYPE.Information)

class BaseNotifier(object):
    __slots__ = ()

    def getPath(self):
        raise NotImplementedError


class SimpleSysMessageNotifier(BaseNotifier):
    __slots__ = ('__states', '__path')

    def __init__(self, path, states):
        self.__path = path
        self.__states = states

    def __call__(self, nextValue, currentValue):
        if (
         currentValue, nextValue) in self.__states:
            msg = self.__states[(currentValue, nextValue)]
            SystemMessages.pushMessage(backport.text(msg.resID), priority=msg.priority, type=msg.type)

    def getPath(self):
        return self.__path