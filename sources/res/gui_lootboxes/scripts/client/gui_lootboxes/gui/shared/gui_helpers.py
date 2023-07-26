from frameworks.wulf.view.array import fillStringsArray
from gui_lootboxes.gui.impl.gen.view_models.views.lobby.gui_lootboxes.lootbox_view_model import LootboxViewModel

def getLootBoxViewModel(lootBox):
    lbModel = LootboxViewModel()
    lbModel.setTier(lootBox.getTier())
    lbModel.setBoxID(lootBox.getID())
    lbModel.setBoxType(lootBox.getType())
    lbModel.setCount(lootBox.getInventoryCount())
    lbModel.setIsOpenEnabled(lootBox.isEnabled())
    lbModel.setUserName(lootBox.getUserNameKey())
    lbModel.setIconName(lootBox.getIconName())
    lbModel.setDescriptionKey(lootBox.getDesrciption())
    lbModel.setVideoRes(lootBox.getVideoRes())
    fillStringsArray(lootBox.getBonusGroups(), lbModel.getBonusGroups())
    return lbModel