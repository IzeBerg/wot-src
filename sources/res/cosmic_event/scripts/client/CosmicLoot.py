import BigWorld, CGF, Math, cosmic_prefabs
from cosmic_event_common.cosmic_constants import LOOT_TYPE

class CosmicLoot(BigWorld.Entity):
    LOOT_TYPE_ID_TO_PREFAB = {LOOT_TYPE.COSMIC_BLACK_HOLE: cosmic_prefabs.Loot.COSMIC_BLACK_HOLE, 
       LOOT_TYPE.COSMIC_SHOOTING: cosmic_prefabs.Loot.COSMIC_SHOOTING, 
       LOOT_TYPE.COSMIC_GRAVITY_FIELD: cosmic_prefabs.Loot.COSMIC_GRAVITY_FIELD}

    def onEnterWorld(self, *args):
        prefab = self.LOOT_TYPE_ID_TO_PREFAB.get(self.typeID)
        if prefab:
            CGF.loadGameObjectIntoHierarchy(prefab, self.entityGameObject, Math.Vector3())