import BigWorld, CGF, Math, cosmic_prefabs
from cosmic_event_common.cosmic_constants import LOOT_TYPE
from debug_utils import LOG_ERROR

class CosmicLoot(BigWorld.Entity):
    LOOT_TYPE_ID_TO_PREFAB = {LOOT_TYPE.COSMIC_VORTEX: cosmic_prefabs.Loot.COSMIC_VORTEX, 
       LOOT_TYPE.COSMIC_REPULSOR: cosmic_prefabs.Loot.COSMIC_REPULSOR, 
       LOOT_TYPE.COSMIC_JUMP: cosmic_prefabs.Loot.COSMIC_JUMP, 
       LOOT_TYPE.COSMIC_MINES: cosmic_prefabs.Loot.COSMIC_MINES}

    def onEnterWorld(self, *args):
        prefab = self.LOOT_TYPE_ID_TO_PREFAB.get(self.typeID)
        if prefab:
            CGF.loadGameObjectIntoHierarchy(prefab, self.entityGameObject, Math.Vector3())
        else:
            LOG_ERROR(("Couldn't find Cosmic loot prefab by id='{}'").format(self.typeID))