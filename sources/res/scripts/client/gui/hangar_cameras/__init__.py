from skeletons.gui.hangar_cameras import IHangarCameraSounds
__all__ = ('getHangarCamerasConfig', )

def getHangarCamerasConfig(manager):
    from gui.hangar_cameras.hangar_camera_sounds import HangarCameraSounds
    ctrl = HangarCameraSounds()
    ctrl.init()
    manager.addInstance(IHangarCameraSounds, ctrl, finalizer='fini')