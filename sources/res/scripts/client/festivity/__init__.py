from skeletons.festivity_factory import IFestivityFactory
from skeletons.new_year import INewYearController, ICustomizableObjectsManager

def getFestivityConfig(manager):
    from new_year.customizable_objects_manager import CustomizableObjectsManager
    from new_year.ny_factory import NewYearFactory
    festivityFactory = NewYearFactory()
    manager.addInstance(IFestivityFactory, festivityFactory)

    def _create():
        customizableObjMgr = CustomizableObjectsManager()
        customizableObjMgr.init()
        return customizableObjMgr

    manager.addRuntime(ICustomizableObjectsManager, _create, finalizer='fini')
    manager.addInstance(INewYearController, festivityFactory.getController())