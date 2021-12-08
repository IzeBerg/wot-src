from skeletons.festivity_factory import IFestivityFactory
from skeletons.new_year import ICustomizableObjectsManager

def getNewYearServiceConfig(manager):
    from .customizable_objects_manager import CustomizableObjectsManager
    from new_year.ny_factory import NewYearFactory
    custObjMgr = CustomizableObjectsManager()
    custObjMgr.init()
    manager.addInstance(ICustomizableObjectsManager, custObjMgr, finalizer='fini')
    manager.addInstance(IFestivityFactory, NewYearFactory())