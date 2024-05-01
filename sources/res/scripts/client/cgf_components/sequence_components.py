import CGF, GenericComponents
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent
from cgf_script.managers_registrator import onAddedQuery, onRemovedQuery, autoregister

@registerComponent
class OnDisappearPrefabSpawner(object):
    prefab = ComponentProperty(type=CGFMetaTypes.STRING, editorName='prefab', value='', annotations={'path': '*.prefab'})


@registerComponent
class OnAppearPrefabSpawner(object):
    prefab = ComponentProperty(type=CGFMetaTypes.STRING, editorName='prefab', value='', annotations={'path': '*.prefab'})


@autoregister(presentInAllWorlds=True, domain=CGF.DomainOption.DomainClient)
class PrefabSpawnerManager(CGF.ComponentManager):

    @onAddedQuery(OnAppearPrefabSpawner, GenericComponents.TransformComponent)
    def onAppear(self, spawner, transform):
        CGF.loadGameObject(spawner.prefab, self.spaceID, transform.worldTransform, self._onGameObjectLoaded)

    @onRemovedQuery(OnDisappearPrefabSpawner, GenericComponents.TransformComponent)
    def onDisappear(self, spawner, transform):
        CGF.loadGameObject(spawner.prefab, self.spaceID, transform.worldTransform, self._onGameObjectLoaded)

    @staticmethod
    def _onGameObjectLoaded(gameObject):
        gameObject.activate()
        gameObject.transferOwnershipToWorld()