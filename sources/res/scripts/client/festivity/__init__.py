from festivity.dummy.df_factory import DummyFactory
from skeletons.festivity_factory import IFestivityFactory

def getFestivityConfig(manager):
    festivityFactory = DummyFactory()
    manager.addInstance(IFestivityFactory, festivityFactory)