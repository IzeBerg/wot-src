

class BaseMessagesController(object):

    def __init__(self, model):
        self._model = model

    def cleanUp(self):
        self._model = None
        return