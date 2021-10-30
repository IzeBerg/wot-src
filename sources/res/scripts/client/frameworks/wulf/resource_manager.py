import typing
from .py_object_binder import PyObjectEntity

class ResourceManager(PyObjectEntity):

    @classmethod
    def create(cls, proxy):
        manager = ResourceManager()
        manager.bind(proxy)
        return manager

    def destroy(self):
        self.unbind()

    def getTranslatedText(self, resourceID):
        return self.proxy.getTranslatedText(resourceID)

    def getImagePath(self, resourceID):
        return self.proxy.getImagePath(resourceID)

    def getSoundEffectId(self, resourceID):
        return self.proxy.getSoundEffectId(resourceID)