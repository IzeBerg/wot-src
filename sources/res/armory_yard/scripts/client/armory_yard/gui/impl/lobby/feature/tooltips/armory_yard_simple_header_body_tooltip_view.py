from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.windows.simple_tooltip_content_model import SimpleTooltipContentModel
from gui.impl.pub import ViewImpl

class ArmoryYardSimpleHeaderBodyTooltipView(ViewImpl):
    __slots__ = ('__header', '__body')

    def __init__(self, header, body):
        settings = ViewSettings(R.views.armory_yard.lobby.feature.tooltips.ArmoryYardSimpleTooltipView())
        settings.model = SimpleTooltipContentModel()
        self.__header = header
        self.__body = body if body is not None else ''
        super(ArmoryYardSimpleHeaderBodyTooltipView, self).__init__(settings)
        return

    @property
    def viewModel(self):
        return super(ArmoryYardSimpleHeaderBodyTooltipView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(ArmoryYardSimpleHeaderBodyTooltipView, self)._onLoading(*args, **kwargs)
        with self.viewModel.transaction() as (tx):
            tx.setHeader(self.__header)
            tx.setBody(self.__body)