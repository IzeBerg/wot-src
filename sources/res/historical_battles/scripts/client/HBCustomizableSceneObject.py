from helpers import dependency
from ClientSelectableObject import ClientSelectableObject
from historical_battles.skeletons.gui.customizable_objects_manager import ICustomizableObjectsManager

class HBCustomizableSceneObject(ClientSelectableObject):
    customizableObjectsMgr = dependency.descriptor(ICustomizableObjectsManager)

    def onEnterWorld(self, prereqs):
        super(HBCustomizableSceneObject, self).onEnterWorld(prereqs)
        self.customizableObjectsMgr.addCustomizableEntity(self)

    def onLeaveWorld(self):
        self.customizableObjectsMgr.removeCustomizableEntity(self)
        super(HBCustomizableSceneObject, self).onLeaveWorld()