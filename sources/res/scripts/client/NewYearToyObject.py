import logging, AnimationSequence, BigWorld
from NewYearSelectableObject import NewYearSelectableObject
from helpers import dependency
from helpers.CallbackDelayer import CallbackDelayer
from helpers.EffectsList import EffectsListPlayer
from helpers.animator_instance_properties import AnimatorInstanceProperties
from skeletons.new_year import ICustomizableObjectsManager
from vehicle_systems.stricted_loading import makeCallbackWeak
_logger = logging.getLogger(__name__)

class NewYearToyObject(NewYearSelectableObject):
    __customizableObjectsMgr = dependency.descriptor(ICustomizableObjectsManager)

    def __init__(self):
        super(NewYearToyObject, self).__init__()
        self.__hangingEffectPlayer = None
        self.__regularEffectPlayer = None
        self.__animators = {}
        self.__alphaFadeFashion = None
        self.__callbackDelayer = None
        return

    def onEnterWorld(self, prereqs):
        if self._selfDestroyCheck():
            return
        super(NewYearToyObject, self).onEnterWorld(prereqs)
        self.__callbackDelayer = CallbackDelayer()
        self.__playEffects()
        if self.minAlpha:
            self.__alphaFadeFashion = BigWorld.WGAlphaFadeFashion()
            self.__alphaFadeFashion.minAlpha = self.minAlpha
            self.__alphaFadeFashion.maxAlphaDist = self.maxAlphaDistance * self.maxAlphaDistance
            self.model.fashion = self.__alphaFadeFashion
        if self.appearanceDelay:
            self.model.visible = False
            self.__callbackDelayer.delayCallback(self.appearanceDelay, self.__showModel)

    def onLeaveWorld(self):
        if self.__hangingEffectPlayer is not None:
            self.__hangingEffectPlayer.stop()
            self.__hangingEffectPlayer = None
        if self.__regularEffectPlayer is not None:
            self.__regularEffectPlayer.stop()
            self.__regularEffectPlayer = None
        for animator in self.__animators.itervalues():
            if animator is not None:
                animator.stop()

        self.__animators.clear()
        self.__callbackDelayer.destroy()
        self.__callbackDelayer = None
        super(NewYearToyObject, self).onLeaveWorld()
        return

    def __playEffects(self):
        if self.hangingEffectName:
            self.__hangingEffectPlayer = self.__createEffectPlayer(self.hangingEffectName)
            if self.__hangingEffectPlayer is not None:
                self.__hangingEffectPlayer.play(self.model)
        if self.regularEffectName:
            self.__regularEffectPlayer = self.__createEffectPlayer(self.regularEffectName)
            if self.__regularEffectPlayer is not None:
                self.__regularEffectPlayer.play(self.model)
        if self.hangingAnimationSequence:
            self.__spawnAnimationSequence(self.hangingAnimationSequence, isHanging=True)
        if self.animationSequence:
            self.__spawnAnimationSequence(self.animationSequence)
        return

    def __createEffectPlayer(self, effectName):
        effect = self.__customizableObjectsMgr.getEffect(effectName)
        if effect is None:
            return
        else:
            effectPlayer = EffectsListPlayer(effect.effectsList, effect.keyPoints)
            return effectPlayer

    def __spawnAnimationSequence(self, resourceName, isHanging=False):
        if resourceName in self.__animators:
            _logger.error('Unable to start animation sequence, because it is already loaded: "%s"', resourceName)
            return
        else:
            if self.model is None:
                _logger.error('Could not spawn animation sequence "%s", because model is not loaded: "%s"', resourceName, self.modelName)
                return
            self.__animators[resourceName] = None
            animProps = AnimatorInstanceProperties(loopCount=1, loop=False) if isHanging else AnimatorInstanceProperties()
            loader = AnimationSequence.Loader(resourceName, self.spaceID, animProps)
            BigWorld.loadResourceListBG((
             loader,), makeCallbackWeak(self.__onAnimatorLoaded, resourceName))
            return

    def __onAnimatorLoaded(self, resourceName, resourceList):
        if resourceName in resourceList.failedIDs:
            _logger.error('animationLoading %s failed', resourceName)
            return
        animator = resourceList[resourceName]
        animator.bindTo(AnimationSequence.ModelWrapperContainer(self.model, self.spaceID))
        animator.start()
        self.__animators[resourceName] = animator
        self.__callbackDelayer.delayCallback(0, self.__checkAnimatorFinish)

    def __showModel(self):
        self.__appearanceDelayCallbackId = None
        self.model.visible = True
        return

    def __checkAnimatorFinish(self):
        for animatorKey, animator in self.__animators.items():
            if animator is not None and not animator.isPlaying():
                self.__animators.pop(animatorKey)

        if self.__animators:
            return 0
        else:
            return