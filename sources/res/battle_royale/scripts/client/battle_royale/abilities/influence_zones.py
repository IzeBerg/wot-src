import math, CGF, Math, GenericComponents, CombatSelectedArea, math_utils
from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS
from battle_royale.abilities.area_abilities import AreaAbilityVisualizer
from cgf_components.marker_component import CombatMarker
from cgf_script.bonus_caps_rules import bonusCapsManager
from cgf_script.component_meta_class import CGFComponent, ComponentProperty, CGFMetaTypes
from cgf_script.managers_registrator import onAddedQuery, onRemovedQuery
from constants import IS_CLIENT
from helpers import dependency
from items import vehicles
if IS_CLIENT:
    from skeletons.gui.battle_session import IBattleSessionProvider
    from InfluenceZone import InfluenceZone
else:

    class Vehicle(object):
        pass


    class InfluenceZone(object):
        pass


    class IBattleSessionProvider(object):
        pass


class InfluenceZoneMultiVisualizer(CGFComponent):
    editorTitle = 'Influence Zone Multi Visualizer'
    category = 'Abilities'
    influencePrefab = ComponentProperty(type=CGFMetaTypes.STRING, value='', editorName='Influence prefab', annotations={'path': '*.prefab'})
    rotateFromCenter = ComponentProperty(type=CGFMetaTypes.BOOL, value=False, editorName='Rotate from center')


class InfluenceZoneTerrainArea(CGFComponent):
    editorTitle = 'Influence Zone Terrain Area'
    category = 'Abilities'
    fullZoneVisual = ComponentProperty(type=CGFMetaTypes.STRING, value='', editorName='Full Zone Visual', annotations={'path': '*.visual'})
    dropOffset = ComponentProperty(type=CGFMetaTypes.FLOAT, value=1000.0, editorName='Drop Offset')

    def __init__(self):
        super(InfluenceZoneTerrainArea, self).__init__()
        self.fullZoneArea = None
        return


class InfluenceZoneEquipmentComponent(CGFComponent):
    editorTitle = 'Influence Zone Equipment'
    userVisible = False
    radius = ComponentProperty(type=CGFMetaTypes.FLOAT, value=0, editorName='Radius')
    zonesCount = ComponentProperty(type=CGFMetaTypes.INT, value=0, editorName='Zones Count')
    zoneRadius = ComponentProperty(type=CGFMetaTypes.FLOAT, value=0, editorName='Zone Radius')

    def __int__(self):
        self.equipment = None
        return

    def setupEquipment(self, equipment):
        self.equipment = equipment
        self.radius = equipment.radius
        self.zonesCount = equipment.zonesCount
        self.zoneRadius = equipment.influenceZone.radius


@bonusCapsManager(ARENA_BONUS_TYPE_CAPS.BATTLEROYALE)
class InfluenceZoneVisualizationManager(CGF.ComponentManager):
    __guiSessionProvider = dependency.descriptor(IBattleSessionProvider)
    ALLY_MARKER_POSTFIX = 'Ally'
    ENEMY_MARKER_POSTFIX = 'Enemy'

    @onAddedQuery(InfluenceZone, CGF.GameObject)
    def onInfluenceZoneSpawn(self, influenceZone, go):
        from battle_royale.abilities.dynamic_cache_loader import DynamicObjectsCacheLoader
        equipment = vehicles.g_cache.equipments()[influenceZone.equipmentID]
        if not equipment.usagePrefab:
            go.createComponent(DynamicObjectsCacheLoader, self.spaceID, influenceZone.equipmentID, influenceZone.zonesPosition, influenceZone.team)
            return

        def postloadSetup(go):
            eqComponent = go.createComponent(InfluenceZoneEquipmentComponent)
            eqComponent.setupEquipment(equipment)
            multiVisualizer = go.findComponentByType(InfluenceZoneMultiVisualizer)
            if multiVisualizer is not None:
                self.__multipositionSpawn(go, multiVisualizer, influenceZone, equipment, equipment.influenceZone.radius)
            markerComponent = go.findComponentByType(CombatMarker)
            if markerComponent is not None:
                postfix = self.ENEMY_MARKER_POSTFIX
                if self.__guiSessionProvider.getArenaDP().isAllyTeam(influenceZone.team):
                    postfix = self.ALLY_MARKER_POSTFIX
                markerComponent.shape += postfix
                markerComponent.disappearanceRadius = equipment.radius + equipment.influenceZone.radius
            terrainAreaComponent = go.findComponentByType(InfluenceZoneTerrainArea)
            if terrainAreaComponent is not None:
                terrainAreaComponent.dropOffset = influenceZone.dropOffset
            return

        CGF.loadGameObjectIntoHierarchy(equipment.usagePrefab, go, Math.Vector3(0, 0, 0), postloadSetup)

    def __multipositionSpawn(self, go, multivisualizer, influenceZone, equipment, radius):
        for zonePosition in influenceZone.zonesPosition:
            localPosition = zonePosition - influenceZone.position
            if multivisualizer.rotateFromCenter:
                transform = math_utils.createRTMatrix((localPosition.yaw, 0, 0), localPosition)
            else:
                transform = math_utils.createTranslationMatrix(localPosition)

            def postloadSetup(go):
                areaVisualizer = go.findComponentByType(AreaAbilityVisualizer)
                if areaVisualizer is not None:
                    areaVisualizer.radius = equipment.zoneRadius
                eqComponent = go.createComponent(InfluenceZoneEquipmentComponent)
                eqComponent.setupEquipment(equipment)
                return

            CGF.loadGameObjectIntoHierarchy(multivisualizer.influencePrefab, go, transform, postloadSetup)

    CUT_OFF_ANGLE = math.radians(60)
    CUT_OFF_DISTANCE = 100

    @onAddedQuery(GenericComponents.TransformComponent, InfluenceZoneEquipmentComponent, InfluenceZoneTerrainArea)
    def terrainAreaInit(self, transform, influenceZoneEquipment, terrainArea):
        fullRadius = influenceZoneEquipment.radius + influenceZoneEquipment.zoneRadius
        terrainArea.fullZoneArea = CombatSelectedArea.CombatSelectedArea()
        terrainArea.fullZoneArea.setup(position=transform.worldPosition, direction=Math.Vector3(0, 0, 1), size=Math.Vector2(fullRadius * 2, fullRadius * 2), visualPath=terrainArea.fullZoneVisual, color=None, marker=None)
        terrainArea.fullZoneArea.area.setMaxHeight(transform.worldPosition.y + terrainArea.dropOffset)
        terrainArea.fullZoneArea.area.enableYCutOff(True)
        terrainArea.fullZoneArea.area.setCutOffDistance(self.CUT_OFF_DISTANCE)
        terrainArea.fullZoneArea.area.setCutOffAngle(self.CUT_OFF_ANGLE)
        return

    @onRemovedQuery(InfluenceZoneEquipmentComponent, InfluenceZoneTerrainArea)
    def terrainAreaDestroy(self, influenceZoneEquipment, terrainArea):
        terrainArea.fullZoneArea.destroy()
        terrainArea.fullZoneArea = None
        return