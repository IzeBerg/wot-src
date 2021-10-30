from gui.sounds.event_hangar_sound_ctrl import EventHangarSoundEnvController
from gui.sounds.sounds_ctrl import SoundsController
from skeletons.gui.event_hangar_sound import IEventHangarSoundEnv
from skeletons.gui.sounds import ISoundsController
__all__ = ('getSoundsConfig', )

def getSoundsConfig(manager):
    ctrl = SoundsController()
    ctrl.init()
    manager.addInstance(ISoundsController, ctrl, finalizer='fini')
    ctrl = EventHangarSoundEnvController()
    ctrl.init()
    manager.addInstance(IEventHangarSoundEnv, ctrl, finalizer='fini')