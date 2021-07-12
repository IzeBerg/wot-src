from gui.prb_control import prbDispatcherProperty, prbEntityProperty

class IPrbListener(object):

    @prbDispatcherProperty
    def prbDispatcher(self):
        return

    @prbEntityProperty
    def prbEntity(self):
        return

    def startPrbListening(self):
        if self.prbEntity is not None and hasattr(self.prbEntity, 'addListener'):
            self.prbEntity.addListener(self)
        return

    def stopPrbListening(self):
        if self.prbEntity is not None:
            self.prbEntity.removeListener(self)
        return