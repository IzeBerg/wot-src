from gui.shared.system_factory import registerGameControllers
from gui_lootboxes.gui.game_control.gui_lootboxes_controller import GuiLootBoxesController
from gui_lootboxes.gui.game_control.gui_lootboxes_intro_controller import GuiLootboxesIntroController
from skeletons.gui.game_control import IGuiLootBoxesController, IGuiLootBoxesIntroController

def registerGuiLootBoxesGameControllers():
    registerGameControllers([
     (
      IGuiLootBoxesController, GuiLootBoxesController, True),
     (
      IGuiLootBoxesIntroController, GuiLootboxesIntroController, False)])