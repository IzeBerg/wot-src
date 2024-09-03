from gui.impl.lobby.container_views.base.context import TankmanContext

class ExampleViewContext(TankmanContext):
    __slots__ = ('_exampleField', )

    def __init__(self, tankmanID):
        self._exampleField = None
        super(ExampleViewContext, self).__init__(tankmanID)
        return

    @property
    def exampleField(self):
        return self._exampleField

    def update(self, tankmanID):
        super(ExampleViewContext, self).update(tankmanID)
        self._exampleField = self._getExampleField()

    def _getExampleField(self):
        return 'some value'