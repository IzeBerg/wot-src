import BigWorld
from Event import Event
from cgf_components_common.state_components import HealthComponent as HealthComponentCGF

class HealthComponent(BigWorld.DynamicScriptComponent, HealthComponentCGF):

    def __init__(self):
        super(HealthComponent, self).__init__()
        self.onHealthChanged = Event()

    def set_health(self, oldHealth):
        self.onHealthChanged(oldHealth, self.health, self.maxHealth)