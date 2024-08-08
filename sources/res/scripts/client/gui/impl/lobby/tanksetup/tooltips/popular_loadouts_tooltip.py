from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.tanksetup.tooltips.popular_loadouts_tooltip_model import PopularLoadoutsTooltipModel
from gui.impl.pub import ViewImpl

def popularLoadoutsTooltip():
    settings = ViewSettings(R.views.lobby.tanksetup.tooltips.PopularLoadoutsTooltip())
    settings.model = PopularLoadoutsTooltipModel()
    return ViewImpl(settings)