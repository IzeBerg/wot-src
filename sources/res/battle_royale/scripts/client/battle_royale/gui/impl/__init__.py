from battle_royale.gui.impl.lobby.tank_setup.ammunition_panel import BattleRoyaleAmmunitionPanelView
from gui.shared.system_factory import registerAmmunitionPanelView

def registerBRViews():
    registerAmmunitionPanelView(BattleRoyaleAmmunitionPanelView)