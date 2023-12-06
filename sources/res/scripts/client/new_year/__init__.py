from skeletons.festivity_factory import IFestivityFactory

def getNewYearServiceConfig(manager):
    from new_year.ny_factory import NewYearFactory
    manager.addInstance(IFestivityFactory, NewYearFactory())