_CHANGE_NOTIFIERS = []

def _getValueFromPath(path, data):
    if not path:
        return data
    else:
        if path[0] in data:
            return _getValueFromPath(path[1:], data[path[0]])
        return


class LobbyContextChangeListener(object):
    __slots__ = ('__notifiers', '__proxy')

    def __init__(self, proxy):
        self.__notifiers = []
        self.__proxy = proxy
        for notifier in _CHANGE_NOTIFIERS:
            self.addNotifier(notifier)

    def addNotifier(self, notifier):
        self.__notifiers.append(notifier)

    def update(self, data):
        for notifier in self.__notifiers:
            path = notifier.getPath()
            currentValue = _getValueFromPath(path, self.__proxy.getServerSettings().getSettings())
            nextValue = _getValueFromPath(path, data)
            if nextValue is not None:
                notifier(nextValue, currentValue)

        return