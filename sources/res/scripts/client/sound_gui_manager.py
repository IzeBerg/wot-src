from collections import namedtuple
CommonSoundSpaceSettings = namedtuple('CommonSoundSpaceSettings', ('name', 'entranceStates',
                                                                   'exitStates',
                                                                   'persistentSounds',
                                                                   'stoppableSounds',
                                                                   'priorities',
                                                                   'autoStart', 'enterEvent',
                                                                   'exitEvent', 'parentSpace'))
CommonSoundSpaceSettings.__new__.func_defaults = (None, ) * len(CommonSoundSpaceSettings._fields)

class ViewSoundExtension(object):
    __commonSoundManagers = {}

    def __init__(self, soundSpace):
        self.__soundSpace = soundSpace

    @property
    def soundManager(self):
        if self.__soundSpace:
            return self.__commonSoundManagers.get(self.__soundSpace.name)
        return self.__soundsManager

    def startSoundSpace(self):
        self.soundManager.startSpace(self.__soundSpace)

    def initSoundManager(self):
        from gui.sounds.ViewSoundManager import _ViewSoundsManager
        if self.__soundSpace:
            soundSpaceName = self.__soundSpace.name
            if soundSpaceName not in self.__commonSoundManagers:
                self.__commonSoundManagers[soundSpaceName] = _ViewSoundsManager()
        else:
            self.__soundsManager = _ViewSoundsManager()
        self.soundManager.register(id(self), self.__soundSpace)
        if self.__soundSpace and self.__soundSpace.parentSpace:
            self.__parentManager = self.__commonSoundManagers.get(self.__soundSpace.parentSpace)
            if self.__parentManager is not None:
                self.__parentManager.register(id(self), CommonSoundSpaceSettings(autoStart=True))
        else:
            self.__parentManager = None
        return

    def destroySoundManager(self):
        if self.soundManager is not None:
            self.soundManager.unregister(id(self))
            self.soundManager.clear(requester=id(self))
            if not self.soundManager.isUsed:
                if self.__soundSpace and not self.__soundSpace.persistentSounds:
                    self.__commonSoundManagers.pop(self.__soundSpace.name)
            self.__soundsManager = None
        if self.__parentManager is not None:
            self.__parentManager.unregister(id(self))
            self.__parentManager.clear(requester=id(self))
            if not self.__parentManager.isUsed:
                self.__commonSoundManagers.pop(self.__soundSpace.parentSpace)
            self.__parentManager = None
        return