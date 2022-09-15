import CGF, GenericComponents, Math
from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS
from battle_royale.abilities.adaptation_restore_health import AdaptationHealthRestoreEffectArea
from cgf_script.bonus_caps_rules import bonusCapsManager
from cgf_script.component_meta_class import CGFComponent, ComponentProperty, CGFMetaTypes
from cgf_script.managers_registrator import onAddedQuery
from items.artefacts import ThunderStrike, ZonesCircle

class AreaAbilityVisualizer(CGFComponent):
    editorTitle = 'Area Ability Visualizer'
    category = 'Abilities'
    areaTransform = ComponentProperty(type=CGFMetaTypes.LINK, value=GenericComponents.TransformComponent, editorName='Area object')

    def __init__(self):
        super(AreaAbilityVisualizer, self).__init__()
        self.manualRadius = None
        return


@bonusCapsManager(ARENA_BONUS_TYPE_CAPS.BATTLEROYALE)
class AreaAbilityVisualizationManager(CGF.ComponentManager):

    def __applyScale(self, transformComponent, radius):
        scaleMatrix = Math.Matrix()
        scaleMatrix.setScale(Math.Vector3(radius, 1.0, radius))
        matrix = transformComponent.transform
        matrix.preMultiply(scaleMatrix)
        transformComponent.transform = matrix

    def __resizeVisualizer(self, visualizer, radius):
        if visualizer.manualRadius is None:
            self.__applyScale(visualizer.areaTransform(), radius)
        return

    @onAddedQuery(AreaAbilityVisualizer)
    def checkManualRadius(self, visualizer):
        if visualizer.manualRadius is not None:
            self.__applyScale(visualizer.areaTransform(), visualizer.manualRadius)
        return

    @onAddedQuery(AreaAbilityVisualizer, ThunderStrike)
    def resizeThunderTransform(self, visualizer, thunderStrike):
        self.__resizeVisualizer(visualizer, thunderStrike.damageRadius)

    @onAddedQuery(AreaAbilityVisualizer, ZonesCircle)
    def resizeZonesCircle(self, visualizer, zonesCircle):
        self.__resizeVisualizer(visualizer, zonesCircle.radius)

    @onAddedQuery(AreaAbilityVisualizer, AdaptationHealthRestoreEffectArea)
    def resizeHealthRestoreAbilityCircle(self, visualizer, area):
        self.__applyScale(visualizer.areaTransform(), area.teamMateRestoringRadius)