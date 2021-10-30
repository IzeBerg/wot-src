

class MigrationProxy(object):
    __slots__ = ('_proto', )

    def __init__(self, proto):
        super(MigrationProxy, self).__init__()
        self._proto = proto

    def clear(self):
        self._proto = None
        return