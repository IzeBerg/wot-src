from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.consumables_setup_model import ConsumablesSetupModel

class HwConsumablesSetupModel(ConsumablesSetupModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=7):
        super(HwConsumablesSetupModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(HwConsumablesSetupModel, self)._initialize()