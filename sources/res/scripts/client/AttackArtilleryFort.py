import Math
from AreaOfEffect import AreaOfEffect

class AttackArtilleryFort(AreaOfEffect):

    @property
    def _direction(self):
        return Math.Vector3(1, 0, 0)