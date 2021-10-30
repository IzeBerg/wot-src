import BigWorld

def IgnoreCallbackIfDestroyed(function):

    def checkIfDestroyed(self, *args, **kwargs):
        if not self.isDestroyed:
            return function(self, *args, **kwargs)

    return checkIfDestroyed