from gui.prb_control.storages.local_storage import LocalStorage

class TrainingStorage(LocalStorage):
    __slots__ = ('isObserver', )

    def __init__(self):
        super(TrainingStorage, self).__init__()
        self.isObserver = False

    def clear(self):
        self.isObserver = False

    def suspend(self):
        self.clear()


class RtsTrainingStorage(LocalStorage):
    __slots__ = ('isCommander', )

    def __init__(self):
        super(RtsTrainingStorage, self).__init__()
        self.isCommander = False

    def clear(self):
        self.isCommander = False

    def suspend(self):
        self.clear()