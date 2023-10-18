import CGF, SoundGroups
from helpers import dependency
from constants import IS_CLIENT, IS_CGF_DUMP
from shared_utils import nextTick
from vehicle_systems.stricted_loading import makeCallbackWeak
from GenericComponents import TransformComponent, AnimatorComponent, DynamicModelComponent
from gui.shared import g_eventBus, EVENT_BUS_SCOPE, events
from gui.hangar_cameras.hangar_camera_common import CameraRelatedEvents, CameraMovementStates
from skeletons.gui.shared.utils import IHangarSpace
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent
from cgf_components.on_click_components import SelectionComponent
from cgf_components.highlight_component import IsHighlighted, HighlightComponent
from cgf_components.hangar_camera_manager import HangarCameraManager
from cgf_script.managers_registrator import onAddedQuery, onRemovedQuery, autoregister
if IS_CLIENT:
    from skeletons.gui.app_loader import IAppLoader
    from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
    from gui.Scaleform.framework.entities.View import ViewKey
    from gui.app_loader.settings import APP_NAME_SPACE
    from ClientSelectableCameraObject import ClientSelectableCameraObject
else:

    class IAppLoader(object):
        pass


CLICK_SOUND = 'play'
HIGHLIGHT_SOUND = 'highlight'

@registerComponent
class StylePreviewComponent(object):
    editorTitle = 'Show view with style for sale'
    category = 'Halloween'
    styleId = ComponentProperty(type=CGFMetaTypes.INT, editorName='Style ID', value=0)
    cameraName = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Camera Name', value='')

    def showView(self):
        from halloween.gui.shared.event_dispatcher import showStylesPreviewView
        showStylesPreviewView(self.styleId)


@registerComponent
class StyleComponent(object):
    editorTitle = 'Hangar Style Component'
    category = 'Halloween'
    light = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Light animator', value=AnimatorComponent)
    marker = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Marker GO', value=CGF.GameObject)
    model = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Model GO', value=CGF.GameObject)


@autoregister(presentInAllWorlds=False, category='Halloween')
class StylePreviewManager(CGF.ComponentManager):
    _hangarSpace = dependency.descriptor(IHangarSpace)
    if not IS_CGF_DUMP:
        __appLoader = dependency.descriptor(IAppLoader)

    def __init__(self, *args):
        super(StylePreviewManager, self).__init__(*args)
        self._prevSelectedGO = None
        self._styleIdToComponents = {}
        self._styleCameras = []
        self.__hrManager = None
        return

    @property
    def hrManager(self):
        if self.__hrManager is None:
            self.__hrManager = CGF.HierarchyManager(self.spaceID)
        return self.__hrManager

    def activate(self):
        g_eventBus.addListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__onCameraEntityUpdated)

    def deactivate(self):
        g_eventBus.removeListener(CameraRelatedEvents.CAMERA_ENTITY_UPDATED, self.__onCameraEntityUpdated)

    def getStyleIds(self):
        return self._styleIdToComponents.keys()

    def showAllMArkers(self):
        app = self.__appLoader.getApp(APP_NAME_SPACE.SF_LOBBY)
        markerView = app.containerManager.getViewByKey(ViewKey(VIEW_ALIAS.LOBBY_VEHICLE_MARKER_VIEW))
        for styleId in self._styleIdToComponents:
            markerView.updateMarkerVisibility(styleId, True)

    @onAddedQuery(SelectionComponent, StylePreviewComponent, CGF.GameObject)
    def handleComponentAdded(self, selectionComponent, stylePreviewComponent, go):
        selectionComponent.onClickAction += lambda : self._switchToStyle(stylePreviewComponent, go)
        self._styleIdToComponents[stylePreviewComponent.styleId] = (stylePreviewComponent, go)
        self._styleCameras.append(stylePreviewComponent.cameraName)

    @onRemovedQuery(SelectionComponent, StylePreviewComponent, CGF.GameObject)
    def handleComponentRemoved(self, selectionComponent, stylePreviewComponent, go):
        selectionComponent.onClickAction -= lambda : self._switchToStyle(stylePreviewComponent, go)

    @onAddedQuery(IsHighlighted, HighlightComponent, DynamicModelComponent, StylePreviewComponent)
    def onDynamicModelHighlightAdded(self, *args):
        SoundGroups.g_instance.playSound2D(HIGHLIGHT_SOUND)

    def deactivateSelection(self):
        for styleId, (_, go) in self._styleIdToComponents.iteritems():
            go.removeComponentByType(SelectionComponent)
            self.__enableMarker(styleId, False)

    def activateSelection(self):
        for styleId, (_, go) in self._styleIdToComponents.iteritems():
            go.createComponent(SelectionComponent)
            self.__enableMarker(styleId, True)

    def selectStyle(self, styleId):
        stylePreviewComponent, go = self._styleIdToComponents.get(styleId)
        self._switchToStyle(stylePreviewComponent, go)

    def isPreviewActive(self):
        return self._prevSelectedGO is not None

    def _switchToStyle(self, stylePreviewComponent, selectedGO):
        SoundGroups.g_instance.playSound2D(CLICK_SOUND)
        if self._prevSelectedGO is None:
            ClientSelectableCameraObject.deselectAll()
        else:
            self.__enableLight(self._prevSelectedGO, False)
        self.__enableLight(selectedGO, True)
        if self._prevSelectedGO and not self._prevSelectedGO.findComponentByType(SelectionComponent):
            self._prevSelectedGO.createComponent(SelectionComponent)
        if selectedGO.findComponentByType(SelectionComponent):
            selectedGO.removeComponentByType(SelectionComponent)
        self.__enableMarker(stylePreviewComponent.styleId, False)
        if self._prevSelectedGO:
            styleId = self._prevSelectedGO.findComponentByType(StylePreviewComponent).styleId
            self.__enableMarker(styleId, True)
        self._prevSelectedGO = selectedGO
        cameraManager = CGF.getManager(self._hangarSpace.spaceID, HangarCameraManager)
        cameraManager.switchByCameraName(stylePreviewComponent.cameraName, False)
        stylePreviewComponent.showView()
        return

    def __onCameraEntityUpdated(self, event):
        state = event.ctx['state']
        if state == CameraMovementStates.MOVING_TO_OBJECT:
            if self._prevSelectedGO:
                styleId = self._prevSelectedGO.findComponentByType(StylePreviewComponent).styleId
                self.__enableMarker(styleId, False)
            return
        if self._prevSelectedGO and not self._prevSelectedGO.findComponentByType(SelectionComponent):
            self._prevSelectedGO.createComponent(SelectionComponent)
            self.__enableLight(self._prevSelectedGO, False)
            self._prevSelectedGO = None
        for styleId in self._styleIdToComponents:
            self.__enableMarker(styleId, True)

        return

    def __enableLight(self, go, value):
        styleComponent = self.hrManager.getParent(go).findComponentByType(StyleComponent)
        styleComponent.light().setFloatParam('selectedStatus', value)

    def __enableMarker(self, styleID, value):
        _, go = self._styleIdToComponents.get(styleID)
        styleComponent = self.hrManager.getParent(go).findComponentByType(StyleComponent)
        if value:
            styleComponent.marker.activate()
        else:
            styleComponent.marker.deactivate()


@registerComponent
class StyleMarker(object):
    editorTitle = 'Marker for style'
    category = 'Halloween'
    icon = ComponentProperty(type=CGFMetaTypes.STRING, editorName='marker icon', value='', annotations={'path': '*.png'})
    textKey = ComponentProperty(type=CGFMetaTypes.STRING, editorName='marker text key', value='#halloween.halloween_lobby:styles/marker/lynx')


@autoregister(presentInAllWorlds=False, category='Halloween')
class StyleMarkersManager(CGF.ComponentManager):
    if not IS_CGF_DUMP:
        __appLoader = dependency.descriptor(IAppLoader)

    @onAddedQuery(CGF.GameObject, StyleMarker, TransformComponent)
    def handleMarkerAdded(self, go, flashMarkerComponent, transformComponent):
        styleID = self._getStyleID(go)
        nextTick(makeCallbackWeak(self._addMarker, styleID, flashMarkerComponent, transformComponent))()

    @onRemovedQuery(CGF.GameObject, StyleMarker)
    def handleMarkerRemoved(self, go, *_):
        styleID = self._getStyleID(go)
        nextTick(makeCallbackWeak(self._removeMarker, styleID))()

    def _addMarker(self, styleID, flashMarkerComponent, transformComponent):
        matrix = transformComponent.worldTransform
        event = events.LobbyMarkerEvents(events.LobbyMarkerEvents.ADD_MARKER, ctx={'entityID': styleID, 'markerComponent': flashMarkerComponent, 'matrix': matrix})
        g_eventBus.handleEvent(event, scope=EVENT_BUS_SCOPE.LOBBY)

    def _removeMarker(self, styleID):
        event = events.LobbyMarkerEvents(events.LobbyMarkerEvents.REMOVE_MARKER, ctx={'entityID': styleID})
        g_eventBus.handleEvent(event, scope=EVENT_BUS_SCOPE.LOBBY)

    def _getMarkerView(self):
        app = self.__appLoader.getApp(APP_NAME_SPACE.SF_LOBBY)
        return app.containerManager.getViewByKey(ViewKey(VIEW_ALIAS.LOBBY_VEHICLE_MARKER_VIEW))

    def _getStyleID(self, gameObject):
        hierarchyManager = CGF.HierarchyManager(self.spaceID)
        styleComponent = hierarchyManager.getParent(gameObject).findComponentByType(StyleComponent)
        stylePreviewComponent = styleComponent.model.findComponentByType(StylePreviewComponent)
        return stylePreviewComponent.styleId