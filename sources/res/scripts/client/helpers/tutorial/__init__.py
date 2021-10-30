from helpers.tutorial.stubs import StubTutorialLoader
from skeletons.tutorial import ITutorialLoader

def getTutorialConfig(manager):
    manager.addInstance(ITutorialLoader, StubTutorialLoader(), finalizer='fini')