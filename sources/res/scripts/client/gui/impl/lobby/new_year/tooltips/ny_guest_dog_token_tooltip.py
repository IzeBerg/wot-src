from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class NyGuestDogTokenTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NyGuestDogTokenTooltip())
        settings.model = ViewModel()
        super(NyGuestDogTokenTooltip, self).__init__(settings)