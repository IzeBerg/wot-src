from frameworks.wulf import View, ViewFlags, ViewSettings
from gui.impl.gen.view_models.windows.window_model import WindowModel
from gui.impl.gen import R

class WindowView(View):
    __slots__ = ()

    def __init__(self, layoutID=R.views.common.standard_window.standard_window.StandardWindow(), flags=ViewFlags.WINDOW_DECORATOR, viewModelClazz=WindowModel):
        super(WindowView, self).__init__(ViewSettings(layoutID, flags, viewModelClazz()))

    @property
    def viewModel(self):
        return super(WindowView, self).getViewModel()