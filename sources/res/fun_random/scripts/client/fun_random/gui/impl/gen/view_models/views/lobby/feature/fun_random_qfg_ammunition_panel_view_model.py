from gui.impl.gen.view_models.views.lobby.tank_setup.ammunition_panel_view_model import AmmunitionPanelViewModel

class FunRandomQfgAmmunitionPanelViewModel(AmmunitionPanelViewModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=2):
        super(FunRandomQfgAmmunitionPanelViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(FunRandomQfgAmmunitionPanelViewModel, self)._initialize()