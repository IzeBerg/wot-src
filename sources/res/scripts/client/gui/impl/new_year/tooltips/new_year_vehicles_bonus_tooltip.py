from frameworks.wulf import View, ViewSettings, ViewModel
from gui.impl.gen import R

class NewYearVehiclesBonusTooltip(View):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.new_year_vehicle_bonus.NewYearVehiclesBonus())
        settings.model = ViewModel()
        super(NewYearVehiclesBonusTooltip, self).__init__(settings)

    def _initialize(self, *args, **kwargs):
        super(NewYearVehiclesBonusTooltip, self)._initialize()