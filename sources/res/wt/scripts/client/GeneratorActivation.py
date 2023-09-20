from script_component.DynamicScriptComponent import DynamicScriptComponent
from Generator import GeneratorActivationComponent

class GeneratorActivation(DynamicScriptComponent):

    def damaged(self):
        go = self.entity.entityGameObject
        activation = go.findComponentByType(GeneratorActivationComponent)
        if activation:
            activation.wasDamaged = True