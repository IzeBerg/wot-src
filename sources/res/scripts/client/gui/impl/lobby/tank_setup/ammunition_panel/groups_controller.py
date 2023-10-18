import BigWorld
from constants import QUEUE_TYPE, PREBATTLE_TYPE
from gui.prb_control import prbDispatcherProperty
from gui.impl.common.ammunition_panel.ammunition_groups_controller import AmmunitionGroupsController, FRONTLINE_GROUPS, RANDOM_GROUPS, HALLOWEEN_GROUPS
from helpers import dependency
from skeletons.gui.game_control import IEpicBattleMetaGameController

class HangarAmmunitionGroupsController(AmmunitionGroupsController):
    __slots__ = ()
    __epicMetaGameCtrl = dependency.descriptor(IEpicBattleMetaGameController)

    @prbDispatcherProperty
    def prbDispatcher(self):
        return

    def _getGroups(self):
        if self._vehicle is None:
            return []
        else:
            if self.prbDispatcher is not None and (self.prbDispatcher.getFunctionalState().isInPreQueue(QUEUE_TYPE.EPIC) or self.prbDispatcher.getFunctionalState().isInUnit(PREBATTLE_TYPE.EPIC)) and self._vehicle.level in self.__epicMetaGameCtrl.getValidVehicleLevels():
                return FRONTLINE_GROUPS
            hwEqCtrl = BigWorld.player().components.get('HWAccountEquipmentController', None)
            if self.prbDispatcher is not None and hwEqCtrl is not None and (self.prbDispatcher.getFunctionalState().isInPreQueue(QUEUE_TYPE.HALLOWEEN_BATTLES) or self.prbDispatcher.getFunctionalState().isInUnit(PREBATTLE_TYPE.HALLOWEEN_BATTLES) or self.prbDispatcher.getFunctionalState().isInPreQueue(QUEUE_TYPE.HALLOWEEN_BATTLES_WHEEL)):
                return HALLOWEEN_GROUPS
            return RANDOM_GROUPS