from gui.Scaleform.daapi.view.battle.shared.consumables_panel import ConsumablesPanel
from gui.Scaleform.genConsts.CONSUMABLES_PANEL_SETTINGS import CONSUMABLES_PANEL_SETTINGS

class MapsTrainingConsumablesPanel(ConsumablesPanel):

    def _getPanelSettings(self):
        return CONSUMABLES_PANEL_SETTINGS.MAPS_TRAINING_SETTINGS_ID