

class BWEntitiyComponentTracker(object):

    def onDynamicComponentCreated(self, component):
        existing = self.entityGameObject.findComponentByType(type(component))
        if existing is None:
            self.entityGameObject.addComponent(component)
        supMethod = getattr(super(BWEntitiyComponentTracker, self), 'onDynamicComponentCreated', None)
        if supMethod is not None:
            supMethod(self, component)
        return

    def onDynamicComponentDestroyed(self, component):
        existing = self.entityGameObject.findComponentByType(type(component))
        if existing is component:
            self.entityGameObject.removeComponent(component)
        supMethod = getattr(super(BWEntitiyComponentTracker, self), 'onDynamicComponentDestroyed', None)
        if supMethod is not None:
            supMethod(self, component)
        return