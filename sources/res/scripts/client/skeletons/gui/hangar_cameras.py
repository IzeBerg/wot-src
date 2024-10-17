

class IHangarCameraSounds(object):

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def playMotionToObject(self):
        raise NotImplementedError

    def playMotionToMain(self):
        raise NotImplementedError