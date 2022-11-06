from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class TutorialManagerMeta(BaseDAAPIComponent):

    def onComponentFound(self, componentId, viewTutorialId):
        self._printOverrideError('onComponentFound')

    def onComponentDisposed(self, componentId):
        self._printOverrideError('onComponentDisposed')

    def onTriggerActivated(self, componentId, triggerId, state):
        self._printOverrideError('onTriggerActivated')

    def onEffectCompleted(self, componentId, effectType):
        self._printOverrideError('onEffectCompleted')

    def onUbTrackedVarChanged(self, viewTutorialId, botNetID, varName, value):
        self._printOverrideError('onUbTrackedVarChanged')

    def as_setSystemEnabledS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSystemEnabled(value)

    def as_setDescriptionsS(self, descriptions):
        if self._isDAAPIInited():
            return self.flashObject.as_setDescriptions(descriptions)

    def as_setCriteriaS(self, criteriaName, criteriaValue):
        if self._isDAAPIInited():
            return self.flashObject.as_setCriteria(criteriaName, criteriaValue)

    def as_setTriggersS(self, componentId, triggers):
        if self._isDAAPIInited():
            return self.flashObject.as_setTriggers(componentId, triggers)

    def as_showEffectS(self, viewTutorialId, componentId, effType, builderData):
        if self._isDAAPIInited():
            return self.flashObject.as_showEffect(viewTutorialId, componentId, effType, builderData)

    def as_hideEffectS(self, viewTutorialId, componentId, effType, builder):
        if self._isDAAPIInited():
            return self.flashObject.as_hideEffect(viewTutorialId, componentId, effType, builder)

    def as_setComponentViewCriteriaS(self, componentId, viewTutorialId):
        if self._isDAAPIInited():
            return self.flashObject.as_setComponentViewCriteria(componentId, viewTutorialId)

    def as_getComponentGlobalBoundsS(self, viewTutorialId, componentID):
        if self._isDAAPIInited():
            return self.flashObject.as_getComponentGlobalBounds(viewTutorialId, componentID)

    def as_getComponentPathS(self, viewTutorialId, botNetID):
        if self._isDAAPIInited():
            return self.flashObject.as_getComponentPath(viewTutorialId, botNetID)

    def as_setConditionsS(self, conditions):
        if self._isDAAPIInited():
            return self.flashObject.as_setConditions(conditions)

    def as_externalComponentFoundS(self, componentID, viewTutorialId, data):
        if self._isDAAPIInited():
            return self.flashObject.as_externalComponentFound(componentID, viewTutorialId, data)

    def as_updateExternalComponentS(self, componentID, viewTutorialId, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateExternalComponent(componentID, viewTutorialId, data)

    def as_disposeExternalComponentS(self, componentID, viewTutorialId):
        if self._isDAAPIInited():
            return self.flashObject.as_disposeExternalComponent(componentID, viewTutorialId)