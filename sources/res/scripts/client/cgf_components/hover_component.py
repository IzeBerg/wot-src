import BigWorld, CGF, GUI
from GenericComponents import VSEComponent
from cgf_script.managers_registrator import tickGroup, onAddedQuery, onRemovedQuery
from cgf_script.component_meta_class import CGFComponent
from constants import IS_CLIENT, CollisionFlags
from vehicle_systems.tankStructure import ColliderTypes
from helpers import dependency
from skeletons.gui.shared.utils import IHangarSpace
if IS_CLIENT:
    from AvatarInputHandler import cameras

class IsHoverable(CGFComponent):
    pass


class IsHovered(CGFComponent):
    pass


class HoverManager(CGF.ComponentManager):
    _hangarSpace = dependency.descriptor(IHangarSpace)

    @onAddedQuery(VSEComponent, IsHovered)
    def onIsHoveredAdded(self, vseComponent, *args):
        vseComponent.context.onGameObjectHoverIn()

    @onRemovedQuery(VSEComponent, IsHovered)
    def onIsHoveredRemoved(self, vseComponent, *args):
        vseComponent.context.onGameObjectHoverOut()

    @onRemovedQuery(CGF.GameObject, IsHoverable)
    def onIsHoverableRemoved(self, gameObject, *args):
        if gameObject.findComponentByType(IsHovered):
            gameObject.removeComponentByType(IsHovered)

    @tickGroup(groupName='Simulation')
    def tick(self):
        gameObjectID = None
        if GUI.mcursor().inWindow and GUI.mcursor().inFocus and self._hangarSpace.isSelectionEnabled and self._hangarSpace.isCursorOver3DScene:
            gameObjectID = self.__getGameObjectUnderCursor()
        hoveredGameObject = CGF.Query(self.spaceID, (CGF.GameObject, IsHovered))
        for gameObject, _ in hoveredGameObject:
            if gameObject.id != gameObjectID:
                gameObject.removeComponentByType(IsHovered)
            else:
                return

        if gameObjectID is None:
            return
        else:
            hoverableGameObjects = CGF.Query(self.spaceID, (CGF.GameObject, IsHoverable))
            for gameObject, _ in hoverableGameObjects:
                if gameObject.id == gameObjectID:
                    gameObject.createComponent(IsHovered)

            return

    def __getGameObjectUnderCursor(self):
        cursorPosition = GUI.mcursor().position
        ray, wpoint = cameras.getWorldRayAndPoint(cursorPosition.x, cursorPosition.y)
        skipFlags = CollisionFlags.TRIANGLE_PROJECTILENOCOLLIDE | CollisionFlags.TRIANGLE_NOCOLLIDE
        res = BigWorld.wg_collideDynamicStatic(self.spaceID, wpoint, wpoint + ray * 1500, skipFlags, 0, -1, ColliderTypes.HANGAR_FLAG)
        if res is not None:
            return res[2]
        else:
            return