from skeletons.gui.customization import ICustomizationService
__all__ = ('getCustomizationServiceConfig', )

def getCustomizationServiceConfig(manager):
    from gui.customization.service import CustomizationService

    def _create():
        instance = CustomizationService()
        instance.init()
        return instance

    manager.addRuntime(ICustomizationService, _create, finalizer='fini')