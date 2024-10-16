import CGF, GenericComponents
from cgf_script.component_meta_class import ComponentProperty, CGFMetaTypes, registerComponent

class _AnimatorStatus(object):
    STATUS_ENABLED = 1.0
    STATUS_DISABLED = 0.0


@registerComponent
class SoulCollectorProgressComponent(object):
    category = 'Halloween'
    editorTitle = 'Soul Collector Progress Component'
    progressSectors = ComponentProperty(type=CGFMetaTypes.INT, editorName='Progress Sectors', value=0)
    sectorOffsetY = ComponentProperty(type=CGFMetaTypes.FLOAT, editorName='Progress Sector Y Offset', value=0.0)
    progressSequence = ComponentProperty(type=CGFMetaTypes.STRING, editorName='Progress Sequence', value='')

    def __init__(self):
        super(SoulCollectorProgressComponent, self).__init__()
        self._currentProgress = 0
        self._gos = []
        self._animators = []

    def init(self, go):
        for i in xrange(0, self.progressSectors):
            newGO = CGF.GameObject(go.spaceID)
            newGO.createComponent(GenericComponents.HierarchyComponent, go)
            newGO.createComponent(GenericComponents.TransformComponent, (0.0, float(i) * self.sectorOffsetY, 0.0))
            newAnimator = newGO.createComponent(GenericComponents.AnimatorComponent, self.progressSequence, 0, 1, -1, True, '')
            newAnimator.start()
            self._gos.append(newGO)
            self._animators.append(newAnimator)

    def isReady(self):
        return all(animator.isPlaying() for animator in self._animators)

    def onDestroy(self):
        self._animators = []
        self._gos = []

    def update(self, progress):
        newProgress = int(self.progressSectors * progress)
        if newProgress == self._currentProgress:
            return
        for i, animator in enumerate(self._animators):
            if i < newProgress:
                animator.setFloatParam('Status', _AnimatorStatus.STATUS_ENABLED)
            elif i >= newProgress:
                animator.setFloatParam('Status', _AnimatorStatus.STATUS_DISABLED)

        self._currentProgress = newProgress


@registerComponent
class SoulCollectorComponent(object):
    category = 'Halloween'
    editorTitle = 'SoulCollectorComponent'
    loadProgressGO = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Progress GO', value=CGF.GameObject)
    energyGlowAnimator = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Energy Glow Animator', value=GenericComponents.AnimatorComponent)
    auraAnimator = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Aura Animator', value=GenericComponents.AnimatorComponent)
    drainerAnimator = ComponentProperty(type=CGFMetaTypes.LINK, editorName='Drainer Animator', value=GenericComponents.AnimatorComponent)

    def __init__(self):
        super(SoulCollectorComponent, self).__init__()
        self._progressComponent = None
        self._isReady = False
        return

    def onDestroy(self):
        self._progressComponent.onDestroy()
        self._progressComponent = None
        return

    @property
    def isReady(self):
        if not self._isReady:
            self._isReady = self.energyGlowAnimator() is not None and self.auraAnimator() is not None and self.drainerAnimator() is not None and self._progressComponent.isReady()
        return self._isReady

    def updateProgress(self, progress):
        if self.energyGlowAnimator():
            self.energyGlowAnimator().setFloatParam('FillStatus', progress)
        if self.auraAnimator():
            self.auraAnimator().setFloatParam('FillStatus', progress)
        self._progressComponent.update(progress)

    def updateIsCollecting(self, isCollecting):
        if self.drainerAnimator():
            self.drainerAnimator().setFloatParam('DrainStatus', _AnimatorStatus.STATUS_ENABLED if isCollecting else _AnimatorStatus.STATUS_DISABLED)

    def _init(self):
        self._progressComponent = self.loadProgressGO.findComponentByType(SoulCollectorProgressComponent)
        self._progressComponent.init(self.loadProgressGO)

    @staticmethod
    def init(go):
        self = go.findComponentByType(SoulCollectorComponent)
        if self is None:
            return
        else:
            self._init()
            return self