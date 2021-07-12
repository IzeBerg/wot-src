import importlib, BigWorld

class GameObject(BigWorld.Entity):

    def onEnterWorld(self, prereqs):
        module = importlib.import_module(self.clientScript)
        getattr(module, self.clientFunction)(self)