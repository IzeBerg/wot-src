import functools, random, math, time, GenericComponents, Triggers, CGF, Math
from cgf_demo.demo_category import DEMO_CATEGORY
from cgf_script.component_meta_class import CGFComponent, ComponentProperty, CGFMetaTypes
from cgf_demo.test_movers import TestScriptAxisRotator
from cgf_script.managers_registrator import autoregister, tickGroup, onAddedQuery
import logging
_logger = logging.getLogger(__name__)

class TestRotateWhileInTrigger(CGFComponent):
    category = DEMO_CATEGORY
    rotationSpeed = ComponentProperty(type=CGFMetaTypes.FLOAT, editorName='rotation speed when anyone is present', value=1.0)


class TestComponentCreation(CGFComponent):
    category = DEMO_CATEGORY
    trigger = ComponentProperty(type=CGFMetaTypes.LINK, editorName='AreaTrigger to subscribe', value=Triggers.AreaTriggerComponent)
    rotationSpeed = ComponentProperty(type=CGFMetaTypes.FLOAT, editorName='rotation speed', value=0.0)


class TestPrefabSpawner(CGFComponent):
    category = DEMO_CATEGORY
    prefabPath = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Prefab to spawn', value='content/Prefabs/1003_cgf_test/TestExplosion.prefab', annotations={'path': '*.prefab'})
    instancesCount = ComponentProperty(type=CGFMetaTypes.INT, editorName='Instances count', value=1)
    areaToSpawn = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Area to spawn', value=Triggers.CylinderAreaComponent)
    triggerToMonitor = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Trigger to monitor', value=Triggers.AreaTriggerComponent)
    transform = ComponentProperty(type=CGFMetaTypes.LINK, editorName='transform', value=GenericComponents.TransformComponent)
    attachToEntered = ComponentProperty(type=CGFMetaTypes.BOOL, editorName='attach to entered', value=False)


class TestComponentCreationManager(CGF.ComponentManager):

    @onAddedQuery(TestComponentCreation)
    def onTestComponentCreationAdded(self, testComponentCreation):
        trigger = testComponentCreation.trigger()
        if trigger:
            trigger.addEnterReaction(functools.partial(self.__componentCreationEnter, testComponentCreation))
            trigger.addExitReaction(functools.partial(self.__componentCreationExit, testComponentCreation))

    @onAddedQuery(TestPrefabSpawner)
    def onPrefabSpawnerAdded(self, prefabSpawner):
        trigger = prefabSpawner.triggerToMonitor()
        if trigger:
            trigger.addEnterReaction(functools.partial(self.__onPrefabSpawnerEnter, prefabSpawner))

    def __componentCreationEnter(self, creator, who, where):
        _logger.debug('TestComponentCreation. Trigger entered')
        if where.findComponentByType(TestScriptAxisRotator) is not None:
            return
        else:
            rotator = where.createComponent(TestScriptAxisRotator)
            rotator.rotationSpeedYaw = creator.rotationSpeed
            rotator.rotationSpeedPitch = 0
            rotator.rotationSpeedRoll = creator.rotationSpeed
            rotator.transform = CGF.ComponentLink(where, GenericComponents.TransformComponent)
            return

    def __componentCreationExit(self, creator, who, where):
        scriptRotator = where.findComponentByType(TestScriptAxisRotator)
        if scriptRotator is not None:
            where.removeComponent(scriptRotator)
        return

    def __onPrefabSpawnerEnter(self, spawner, who, where):
        for x in xrange(spawner.instancesCount):
            self.__spawn(spawner, who)

    def __spawn(self, spawner, who):
        if spawner.attachToEntered:

            def _onLoaded(gameObject):
                import Vehicle
                h = CGF.HierarchyManager(self.spaceID)
                vehicleGo = h.getTopMostParent(who)
                vehicle = vehicleGo.findComponentByType(Vehicle.Vehicle)
                appearance = vehicle.appearance
                appearance.undamagedStateChildren.append(gameObject)
                gameObject.createComponent(GenericComponents.RedirectorComponent, who)
                gameObject.createComponent(GenericComponents.DynamicModelComponent, vehicle.model)

            CGF.loadGameObjectIntoHierarchy(spawner.prefabPath, who, Math.Vector3(0, 0, 0), _onLoaded)
            return
        area = spawner.areaToSpawn()
        transform = spawner.transform()
        if not area:
            return
        _logger.debug('TestPrefabSpawner. Create prefab = %s' % spawner.prefabPath)
        u = random.random()
        yaw = 2 * math.pi * u
        pos = Math.Vector3(math.sin(yaw) * area.radius, 0, math.cos(yaw) * area.radius)
        pos.y = random.random() * area.height
        pos += transform.worldPosition

        def randomizeDestructionTime(go):
            remove = go.findComponentByType(GenericComponents.RemoveGoDelayedComponent)
            remove.delay = 1 + random.random() * 9

        CGF.loadGameObject(spawner.prefabPath, self.spaceID, pos, randomizeDestructionTime)


class TestTriggersManager(CGF.ComponentManager):
    whileInTrigger = CGF.QueryConfig(TestRotateWhileInTrigger, Triggers.AreaTriggerComponent, TestScriptAxisRotator)

    @tickGroup('Simulation')
    def tick(self):
        for config, trigger, rotator in self.whileInTrigger:
            if trigger.objectsInProximity:
                rotator.rotationSpeedYaw = config.rotationSpeed
            else:
                rotator.rotationSpeedYaw = 0.0