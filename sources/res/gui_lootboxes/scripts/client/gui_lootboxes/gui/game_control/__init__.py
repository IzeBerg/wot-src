from gui.shared.system_factory import registerGameControllers
from gui_lootboxes.gui.game_control.gui_lootboxes_controller import GuiLootBoxesController
from skeletons.gui.game_control import IGuiLootBoxesController

def registerGuiLootBoxesGameControllers():
    registerGameControllers([
     (
      IGuiLootBoxesController, GuiLootBoxesController, False)])