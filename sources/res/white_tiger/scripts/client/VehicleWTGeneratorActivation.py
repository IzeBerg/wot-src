from script_component.DynamicScriptComponent import DynamicScriptComponent
from EntityWTGeneratorComponent import GeneratorActivationComponent

class VehicleWTGeneratorActivation(DynamicScriptComponent):

    def damaged(self):
        go = self.entity.entityGameObject
        activation = go.findComponentByType(GeneratorActivationComponent)
        if activation:
            activation.wasDamaged = True