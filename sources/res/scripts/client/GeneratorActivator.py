import GenericComponents
from script_component.DynamicScriptComponent import DynamicScriptComponent

class GeneratorActivator(DynamicScriptComponent):

    def _onAvatarReady(self):
        go = self.entity.entityGameObject
        go.createComponent(GenericComponents.TriggerComponent, 'captured')

    def onDestroy(self):
        go = self.entity.entityGameObject
        go.removeComponentByType(GenericComponents.TriggerComponent)
        super(GeneratorActivator, self).onDestroy()