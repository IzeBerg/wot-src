from PlayerEvents import g_playerEvents

class DestroyWindowOnDisconnectMixin(object):
    __slots__ = ()

    def _initialize(self):
        super(DestroyWindowOnDisconnectMixin, self)._initialize()
        g_playerEvents.onDisconnected += self.__disconnectHandler

    def _finalize(self):
        g_playerEvents.onDisconnected -= self.__disconnectHandler
        super(DestroyWindowOnDisconnectMixin, self)._finalize()

    def __disconnectHandler(self):
        self.destroy()