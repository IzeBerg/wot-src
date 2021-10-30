from shared_utils import CONST_CONTAINER

class IVideoSoundManager(object):

    def start(self):
        raise NotImplementedError

    def stop(self):
        raise NotImplementedError

    def pause(self):
        raise NotImplementedError

    def unpause(self):
        raise NotImplementedError


class DummySoundManager(object):

    def start(self):
        pass

    def stop(self):
        pass

    def pause(self):
        pass

    def unpause(self):
        pass


class SoundManagerStates(CONST_CONTAINER):
    PLAYING = 'playing'
    PAUSE = 'pause'
    STOPPED = 'stopped'