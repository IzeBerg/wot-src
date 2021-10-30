from __future__ import absolute_import
from skeletons.tutorial import ITutorialLoader

def getTutorialConfig(manager):
    from tutorial.loader import TutorialLoader
    loader = TutorialLoader()
    loader.init()
    manager.addInstance(ITutorialLoader, loader, finalizer='fini')