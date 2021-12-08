from collections import namedtuple
import BigWorld, ResMgr
from helpers import dependency
import CGF, CameraComponents
from new_year.ny_constants import OBJECT_TO_ANCHOR, AnchorNames
from skeletons.new_year import ICustomizableObjectsManager, ICelebritySceneController
from helpers.EffectsList import effectsFromSection
from items.components.ny_constants import INVALID_TOY_ID
from items import collectibles
from new_year.cgf_components.current_camera_object_manager import CurrentCameraObjectManager
from slot_animation_service import SlotAnimationService
from .customization_camera import CustomizationCamera
_TOY_EFFECTS_CONFIG_FILE = 'scripts/new_year_effects.xml'
_CustomizableNodeDesc = namedtuple('CustomizableNodeDesc', ('isSelectable', 'modelName',
                                                            'outlineModelName', 'regularEffectName',
                                                            'hangingEffectName',
                                                            'animationSequence',
                                                            'hangingAnimationSequence',
                                                            'appearanceDelay'))

class CustomizableObjectsManager(ICustomizableObjectsManager):
    _celebrityController = dependency.descriptor(ICelebritySceneController)

    def __init__(self):
        super(CustomizableObjectsManager, self).__init__()
        self.__currentCameraAnchor = None
        self.__cameraAnchors = {}
        self.__cameraTargets = {}
        self.__customizableObjects = {}
        self.__pendingToys = {}
        self.__effectsCache = {}
        self.__pendingEntitiesToDestroy = set()
        self.__slotsAnimation = None
        self.__cam = CustomizationCamera()
        self.__enities = set()
        return

    def init(self):
        self.__readEffects()
        self.__cam.init()

    def fini(self):
        self.__cam.destroy()
        self.__effectsCache.clear()
        self.__cameraAnchors.clear()
        self.__customizableObjects.clear()
        self.__pendingToys.clear()
        self.__pendingEntitiesToDestroy.clear()
        self.__enities = None
        if self.__slotsAnimation is not None:
            self.__slotsAnimation.fini()
            self.__slotsAnimation = None
        return

    @property
    def pendingEntitiesToDestroy(self):
        return self.__pendingEntitiesToDestroy

    def addCustomizableEntity(self, entity):
        anchorName = entity.anchorName
        self.__customizableObjects[anchorName] = entity
        pendingToys = self.__pendingToys.pop(anchorName, {})
        for node, slotInfo in pendingToys.iteritems():
            entity.updateNode(node, slotInfo)

        if self.__slotsAnimation is None:
            self.__slotsAnimation = SlotAnimationService()
        self.__slotsAnimation.addEntitySlots(entity)
        self.__enities.add(entity)
        return

    def removeCustomizableEntity(self, entity):
        self.__enities.discard(entity)
        if not self.__enities:
            if self.__slotsAnimation is not None:
                self.__slotsAnimation.fini()
            self.__slotsAnimation = None
        anchorName = entity.anchorName
        self.__pendingToys.pop(anchorName, None)
        self.__customizableObjects.pop(anchorName, None)
        return

    def getCustomizableEntity(self, anchorName):
        if anchorName not in self.__customizableObjects:
            return None
        else:
            return self.__customizableObjects[anchorName]

    def addCameraAnchor(self, anchorName, anchor):
        self.__cameraAnchors[anchorName] = anchor

    def removeCameraAnchor(self, anchorName):
        if anchorName in self.__cameraAnchors:
            del self.__cameraAnchors[anchorName]

    def getCameraAnchor(self, anchorName):
        if anchorName not in self.__cameraAnchors:
            return None
        else:
            return self.__cameraAnchors[anchorName]

    def getCurrentCameraAnchor(self):
        return self.__currentCameraAnchor

    def addCameraTarget(self, anchorName, cameraTarget):
        self.__cameraTargets[anchorName] = cameraTarget

    def removeCameraTarget(self, anchorName):
        if anchorName in self.__cameraTargets:
            del self.__cameraTargets[anchorName]

    def getCameraTarget(self, anchorName):
        return self.__cameraTargets.get(anchorName)

    def updateSlot(self, slot, toy, withHangingEffect=True):
        nodes = slot.nodes.split()
        anchorName = OBJECT_TO_ANCHOR[slot.object]
        if toy is None or toy.id == INVALID_TOY_ID:
            if slot.defaultToy != INVALID_TOY_ID:
                toy = collectibles.g_cache.defaultToys.toys.get(slot.defaultToy)
        nodeDesc = None
        if toy is not None:
            toyModelName = getattr(toy, 'model', '')
            toyOutlineModelName = getattr(toy, 'outlineModel', '')
            toyRegularEffect = getattr(toy, 'regularEffect', '')
            toyHangingEffect = getattr(toy, 'hangingEffect', '') if withHangingEffect else ''
            if self.__isDeferredRenderPipeline():
                animationSeqAttr = 'animationSequence'
                hangingAnimationAttr = 'hangingAnimationSequence'
            else:
                animationSeqAttr = 'animationSequenceFwd'
                hangingAnimationAttr = 'hangingAnimationSequenceFwd'
            toyAnimationSequence = getattr(toy, animationSeqAttr, '')
            toyHangingAnimationSequence = getattr(toy, hangingAnimationAttr, '') if withHangingEffect else ''
            toyAppearanceDelay = getattr(toy, 'appearanceDelay', 0.0) if withHangingEffect else 0.0
            direction = slot.direction
            if not toyModelName and direction:
                directionModelAttr = ('').join(('model', '.', direction))
                toyModelName = getattr(toy, directionModelAttr, '')
            if not toyRegularEffect and direction:
                directionRegularEffectAttr = ('').join(('regularEffect', '.', direction))
                toyRegularEffect = getattr(toy, directionRegularEffectAttr, '')
            nodeDesc = _CustomizableNodeDesc(slot.selectable, toyModelName, toyOutlineModelName, toyRegularEffect, toyHangingEffect, toyAnimationSequence, toyHangingAnimationSequence, float(toyAppearanceDelay))
        for nodeName in nodes:
            if anchorName in self.__customizableObjects:
                self.__customizableObjects[anchorName].updateNode(nodeName, nodeDesc)
            else:
                self.__pendingToys.setdefault(anchorName, {})[nodeName] = nodeDesc

        return

    def getEffect(self, effectName):
        return self.__effectsCache.get(effectName)

    def switchCamera(self, anchorName, instantly=False):
        CurrentCameraObjectManager.switchCameraToAnchor(anchorName)
        if anchorName is not None:
            self.__switchToCameraAnchor(anchorName, instantly)
        else:
            self.__currentCameraAnchor = None
            self.__cam.deactivate(instantly)
        return

    def setSlotHighlight(self, slot, isEnabled):
        if self.__slotsAnimation is not None:
            self.__slotsAnimation.changeState(slot, isEnabled)
        return

    def __switchToCameraAnchor(self, anchorName, instantly=False):
        if anchorName == AnchorNames.CELEBRITY and self._celebrityController.isChallengeCompleted:
            anchorName = AnchorNames.CELEBRITY_COMPLETED
        if not BigWorld.player():
            return
        else:
            gameObject = None
            cameraQuery = CGF.Query(BigWorld.player().hangarSpace.spaceID, (
             CGF.GameObject, CameraComponents.CameraComponent))
            for go, camera in cameraQuery:
                if camera.name == anchorName:
                    gameObject = go
                    break

            if gameObject is not None:
                if not self.__cam.isActive():
                    self.__cam.activate()
                    self.__currentCameraAnchor = None
                if self.__currentCameraAnchor == anchorName:
                    return
                self.__currentCameraAnchor = anchorName
                self.__cam.moveToGameObject(gameObject, instantly)
            return

    def __readEffects(self):
        effects = ResMgr.openSection(_TOY_EFFECTS_CONFIG_FILE) or {}
        for effect in effects.values():
            self.__effectsCache[effect.name] = effectsFromSection(effect)

        ResMgr.purge(_TOY_EFFECTS_CONFIG_FILE, True)

    @staticmethod
    def __isDeferredRenderPipeline():
        return BigWorld.getGraphicsSetting('RENDER_PIPELINE') == 0