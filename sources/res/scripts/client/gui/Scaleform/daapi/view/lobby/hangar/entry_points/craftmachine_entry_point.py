from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.CraftMachineEntryPointMeta import CraftMachineEntryPointMeta
from gui.impl.lobby.craft_machine.craftmachine_entry_point_view import CraftmachineEntryPointView

class CraftMachineEntryPoint(CraftMachineEntryPointMeta):

    def _makeInjectView(self):
        self.__view = CraftmachineEntryPointView(ViewFlags.COMPONENT)
        return self.__view