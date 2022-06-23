import CGF, GenericComponents, Math
from GenericComponents import EntityGOSync
from account_helpers.settings_core.settings_constants import GRAPHICS
from cache import cached_property
from cgf_script.component_meta_class import CGFComponent, ComponentProperty, CGFMetaTypes
from cgf_script.managers_registrator import autoregister, onAddedQuery, onProcessQuery, onRemovedQuery
from constants import IS_CGF_DUMP
from helpers import dependency
from helpers.gui_utils import hexARGBToRGBAFloatColor
from skeletons.account_helpers.settings_core import ISettingsCore

class ColorComponent(CGFComponent):
    category = 'UI'
    editorTitle = 'Color Component'
    model = ComponentProperty(type=CGFMetaTypes.LINK, editorName='model', value=GenericComponents.DynamicModelComponent)
    colorParamName = ComponentProperty(type=CGFMetaTypes.STRING, editorName='colorParamName', value='g_color')
    color = ComponentProperty(type=CGFMetaTypes.VECTOR4, value=Math.Vector4(1, 0, 0, 0), editorName='color')

    def __init__(self):
        super(ColorComponent, self).__init__()
        self.currentColor = self.color
        self.currentColorParamName = self.colorParamName
        self.currentModel = self.model


@autoregister(presentInAllWorlds=False, category='UI')
class ColorManager(CGF.ComponentManager):

    @onAddedQuery(ColorComponent)
    def handleColorComponentAdded(self, colorComponent):
        colorComponent.model().setMaterialParameterVector4(colorComponent.colorParamName, colorComponent.color)
        colorComponent.currentColor = colorComponent.color
        colorComponent.currentColorParamName = colorComponent.currentColorParamName
        colorComponent.currentModel = colorComponent.model

    @onProcessQuery(ColorComponent, tickGroup='Simulation')
    def processingHandler(self, colorComponent):
        if colorComponent.currentColor != colorComponent.color or colorComponent.currentModel != colorComponent.model or colorComponent.currentColorParamName != colorComponent.colorParamName:
            colorComponent.model().setMaterialParameterVector4(colorComponent.colorParamName, colorComponent.color)
            colorComponent.currentColor = colorComponent.color
            colorComponent.currentColorParamName = colorComponent.currentColorParamName
            colorComponent.currentModel = colorComponent.model


class ArtilleryFortColorComponent(CGFComponent):
    category = 'Abilities'
    colorComponent = ComponentProperty(type=CGFMetaTypes.LINK, editorName='colorComponent', value=ColorComponent)

    def __init__(self):
        super(ArtilleryFortColorComponent, self).__init__()
        self.entityGO = None
        return

    def changeColor(self):
        if self.entityGO is not None and self.entityGO.isValid():
            goSyncComponent = self.entityGO.findComponentByType(EntityGOSync)
            if goSyncComponent is not None:
                self.colorComponent().color = hexARGBToRGBAFloatColor(goSyncComponent.entity.areaColor)
        return

    def colorSettingsChanged(self, diff):
        if GRAPHICS.COLOR_BLIND in diff:
            self.changeColor()


@autoregister(presentInAllWorlds=False, category='Abilities')
class AttackArtilleryFortColorManager(CGF.ComponentManager):
    if not IS_CGF_DUMP:
        __settingsCore = dependency.descriptor(ISettingsCore)

    @onAddedQuery(CGF.GameObject, ArtilleryFortColorComponent)
    def handleColorComponentAdded(self, gameObject, colorComponent):
        rootGameObject = self.__hierarchyManager.getTopMostParent(gameObject)
        goSyncComponent = rootGameObject.findComponentByType(EntityGOSync)
        if goSyncComponent is not None:
            colorComponent.entityGO = rootGameObject
            colorComponent.changeColor()
            self.__settingsCore.onSettingsChanged += colorComponent.colorSettingsChanged
        return

    @onRemovedQuery(ArtilleryFortColorComponent)
    def handleColorComponentRemoved(self, colorComponent):
        if colorComponent.entityGO is not None:
            self.__settingsCore.onSettingsChanged -= colorComponent.colorSettingsChanged
            colorComponent.entityGO = None
        return

    @cached_property
    def __hierarchyManager(self):
        hierarchyManager = CGF.HierarchyManager(self.spaceID)
        return hierarchyManager