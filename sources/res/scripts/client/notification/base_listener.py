import weakref, typing
if typing.TYPE_CHECKING:
    from notification.NotificationsModel import NotificationsModel
    from typing import Optional

class NotificationListener(object):

    def __init__(self):
        super(NotificationListener, self).__init__()

        def model():
            pass

        self._model = model

    def start(self, model):
        self._model = weakref.ref(model)
        return True

    def stop(self):
        self._model = lambda : None

    def request(self):
        pass