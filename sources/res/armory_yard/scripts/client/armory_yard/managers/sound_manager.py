import WWISE
from armory_yard.gui.Scaleform.daapi.view.lobby.hangar.sound_constants import SOUNDS

class ArmorySoundManager(object):
    __slots__ = ('__isFirstEntrance', )

    def __init__(self):
        self.__isFirstEntrance = True

    def clear(self):
        self.__isFirstEntrance = True

    def onSoundModeChanged(self, isArmorySoundMode):
        if isArmorySoundMode:
            if self.__isFirstEntrance:
                self.__isFirstEntrance = False
                WWISE.WW_eventGlobal(SOUNDS.FIRST_ENTER)
            else:
                WWISE.WW_eventGlobal(SOUNDS.ENTER)
        else:
            WWISE.WW_eventGlobal(SOUNDS.EXIT)