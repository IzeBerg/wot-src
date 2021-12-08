from SimpleDialog import SimpleDialog

class ButtonDialog(SimpleDialog):

    def _callHandler(self, buttonID):
        if self._handler is not None:
            self._handler(buttonID)
            self._isProcessed = True
        return