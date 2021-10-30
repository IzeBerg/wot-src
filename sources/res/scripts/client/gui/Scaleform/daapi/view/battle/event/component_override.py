from gui.battle_control import avatar_getter
from constants import ARENA_GUI_TYPE

class EventComponentOverride(object):
    __slots__ = ('__usualObject', '__eventObject')

    def __init__(self, usualObject, eventObject):
        super(EventComponentOverride, self).__init__()
        self.__usualObject = usualObject
        self.__eventObject = eventObject

    def __call__(self):
        arena = avatar_getter.getArena()
        isEvent = arena.guiType == ARENA_GUI_TYPE.EVENT_BATTLES if arena else False
        if isEvent:
            return self.__eventObject
        return self.__usualObject