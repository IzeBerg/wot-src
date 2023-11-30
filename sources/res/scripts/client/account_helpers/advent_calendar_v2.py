import logging, typing, AccountCommands
if typing.TYPE_CHECKING:
    from typing import Callable, Optional
_logger = logging.getLogger(__name__)

class AdventCalendarManager(object):

    def __init__(self, commandsProxy):
        self.__commandsProxy = commandsProxy

    def openAdventCalendarDoor(self, dayID, currencyName='', callback=None):
        proxy = (lambda requestID, resultID, errorStr: callback(resultID, errorStr)) if callback is not None else None
        self.__commandsProxy.perform(AccountCommands.CMD_OPEN_ADVENT_CALENDAR_DOOR, dayID, currencyName, proxy)
        return