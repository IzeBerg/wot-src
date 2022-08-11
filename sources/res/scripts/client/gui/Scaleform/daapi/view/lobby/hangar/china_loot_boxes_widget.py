from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.cn_loot_boxes.china_loot_boxes_entry_point import ChinaLootBoxesEntryPointWidget

class ChinaLootBoxesWidget(InjectComponentAdaptor):

    def _makeInjectView(self):
        return ChinaLootBoxesEntryPointWidget()