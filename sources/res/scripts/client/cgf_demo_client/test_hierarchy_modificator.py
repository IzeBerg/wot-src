import math, logging, BigWorld
from cgf_script.component_meta_class import CGFComponent, ComponentProperty, CGFMetaTypes
from cgf_script.managers_registrator import autoregister, tickGroup, onAddedQuery
from cgf_demo.demo_category import DEMO_CATEGORY
import GenericComponents, Triggers, CGF, math_utils, Math
from helpers import isPlayerAccount
_logger = logging.getLogger(__name__)

class TestMaterialParamManipulator(CGFComponent):
    category = DEMO_CATEGORY
    model = ComponentProperty(type=CGFMetaTypes.LINK, editorName='model', value=GenericComponents.DynamicModelComponent)
    paramName = ComponentProperty(type=CGFMetaTypes.STRING, editorName='paramName', value='g_tintColor')


@autoregister(presentInAllWorlds=False, category=DEMO_CATEGORY)
class TestMaterialManipulatorManager(CGF.ComponentManager):
    queryManipulator = CGF.QueryConfig(TestMaterialParamManipulator)

    @tickGroup('Simulation')
    def tick1(self):
        for manipulator in self.queryManipulator:
            manipulator.model().setMaterialParameterVector4(manipulator.paramName, Math.Vector4(0, math.sin(self.clock.gameTime), 1, 0))


def _updateTransform(go, newParent):
    objectTransform = go.findComponentByType(GenericComponents.TransformComponent)
    newLocal = objectTransform.worldTransform
    parentTransform = newParent.findComponentByType(GenericComponents.TransformComponent)
    parentInv = parentTransform.worldTransform
    parentInv.invert()
    newLocal.postMultiply(parentInv)
    objectTransform.transform = newLocal


class HierarchyModifier(CGFComponent):
    category = DEMO_CATEGORY
    gameObject1 = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Game Object 1', value='GameObject1')
    gameObject2 = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Game Object 2', value='GameObject2')
    gameObject3 = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Game Object 3', value='GameObject3')
    areaTrigger1 = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Area Trigger1', value=Triggers.AreaTriggerComponent)
    areaTrigger2 = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Area Trigger2', value=Triggers.AreaTriggerComponent)

    def __init__(self):
        super(HierarchyModifier, self).__init__()
        self.__zone1 = False
        self.__zone2 = False
        self.root = None
        self.go1 = None
        self.go2 = None
        self.go3 = None
        return

    def setupRoot(self, root):
        self.root = root
        hierarchy = CGF.HierarchyManager(root.spaceID)
        self.go1 = hierarchy.findFirstNode(root, self.gameObject1)
        self.go2 = hierarchy.findFirstNode(root, self.gameObject2)
        self.go3 = hierarchy.findFirstNode(root, self.gameObject3)

    def __connect(self, rootObject, sourceObj):
        _updateTransform(sourceObj, rootObject)
        CGF.changeHierarchy(self.root, sourceObj.name, rootObject.name)

    def __connectToRoot(self, sourceObj):
        _updateTransform(sourceObj, self.root)
        sourceObj.removeComponentByType(GenericComponents.HierarchyComponent)
        sourceObj.createComponent(GenericComponents.HierarchyComponent, self.root)

    def switchConnectFirstTrigger(self, where):
        _logger.debug('HierarchyModifier. Trigger 1 entered')
        if not self.__zone1:
            self.__connect(self.go1, self.go2)
            self.__zone1 = True
        else:
            self.__connectToRoot(self.go2)
            self.__zone1 = False

    def switchConnectSecondTrigger(self, where):
        _logger.debug('HierarchyModifier. Trigger 2 entered')
        if not self.__zone2:
            self.__connect(self.go2, self.go3)
            self.__zone2 = True
        else:
            self.__connectToRoot(self.go3)
            self.__zone2 = False


class HierarchyModifier2(CGFComponent):
    category = DEMO_CATEGORY
    top = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Top Object', value=CGF.GameObject)
    bottom = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Bottom Object', value=CGF.GameObject)
    box = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Box Object', value=CGF.GameObject)
    cameraTransform = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Camera Transform', value=GenericComponents.TransformComponent)
    areaTrigger = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Area Trigger', value=Triggers.AreaTriggerComponent)

    def unwrapFigure(self, where):
        _logger.debug('HierarchyModifier2. Trigger entered')
        CGF.changeHierarchy(where, 'Head', self.top.name)
        CGF.changeHierarchy(where, 'Back', self.bottom.name)
        CGF.changeHierarchy(where, 'Camera', self.top.name)
        CGF.changeHierarchy(where, 'LH', 'TL')
        CGF.changeHierarchy(where, 'RH', 'TR')
        CGF.changeHierarchy(where, 'LL', 'BL')
        CGF.changeHierarchy(where, 'RL', 'BR')

    def wrapFigure(self, where):
        _logger.debug('HierarchyModifier2. Trigger exited')
        CGF.changeHierarchy(where, 'Head', self.box.name)
        CGF.changeHierarchy(where, 'Back', self.box.name)
        CGF.changeHierarchy(where, 'Camera', 'Bot')
        CGF.changeHierarchy(where, 'LH', self.box.name)
        CGF.changeHierarchy(where, 'RH', self.box.name)
        CGF.changeHierarchy(where, 'LL', self.box.name)
        CGF.changeHierarchy(where, 'RL', self.box.name)


@autoregister(presentInAllWorlds=False, category=DEMO_CATEGORY)
class TestHierarchyModifierManager(CGF.ComponentManager):
    queryCamera = CGF.QueryConfig(HierarchyModifier2)

    @onAddedQuery(HierarchyModifier, CGF.GameObject)
    def onHierarchyModifierAdded(self, hierarchyModifier, go):
        hierarchyModifier.setupRoot(go)
        if hierarchyModifier.areaTrigger1 is not None:
            hierarchyModifier.areaTrigger1().addEnterReaction(lambda who, where: hierarchyModifier.switchConnectFirstTrigger(where))
        if hierarchyModifier.areaTrigger2 is not None:
            hierarchyModifier.areaTrigger2().addEnterReaction(lambda who, where: hierarchyModifier.switchConnectSecondTrigger(where))
        return

    @onAddedQuery(HierarchyModifier2)
    def onHierarchyModifierAdded2(self, hierarchyModifier2):
        if hierarchyModifier2.areaTrigger is not None:
            hierarchyModifier2.areaTrigger().addEnterReaction(lambda who, where: hierarchyModifier2.unwrapFigure(where))
            hierarchyModifier2.areaTrigger().addExitReaction(lambda who, where: hierarchyModifier2.wrapFigure(where))
        return

    @tickGroup('Simulation')
    def tick(self):
        player = BigWorld.player()
        if player is None or isPlayerAccount():
            return
        if hasattr(player, 'getVehicleAttached'):
            vehicle = player.getVehicleAttached()
            if vehicle is None:
                return
            for hmodifier in self.queryCamera:
                transfComp = hmodifier.cameraTransform()
                direction = vehicle.position - transfComp.worldTransform.translation
                matrix = transfComp.transform
                transfComp.transform = math_utils.createRTMatrix((
                 direction.yaw, direction.pitch, 0.0), matrix.translation)

        return