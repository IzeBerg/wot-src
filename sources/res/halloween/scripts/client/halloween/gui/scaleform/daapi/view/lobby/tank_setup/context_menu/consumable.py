from gui.Scaleform.daapi.view.lobby.tank_setup.context_menu.consumable import consumableDecorator, HangarConsumableSlotContextMenu
from halloween.gui.shared.event_dispatcher import showModuleInfo
from ids_generators import SequenceIDGenerator

@consumableDecorator
class HWHangarConsumableSlotContextMenu(HangarConsumableSlotContextMenu):
    _sqGen = SequenceIDGenerator(HangarConsumableSlotContextMenu._sqGen.currSequenceID)

    def _showInfo(self):
        showModuleInfo(self._intCD, self._getVehicle().descriptor)