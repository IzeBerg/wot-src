from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.comp7.schedule_info_model import ScheduleInfoModel

class IntroScreenModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=1, commands=1):
        super(IntroScreenModel, self).__init__(properties=properties, commands=commands)

    @property
    def scheduleInfo(self):
        return self._getViewModel(0)

    @staticmethod
    def getScheduleInfoType():
        return ScheduleInfoModel

    def _initialize(self):
        super(IntroScreenModel, self)._initialize()
        self._addViewModelProperty('scheduleInfo', ScheduleInfoModel())
        self.onClose = self._addCommand('onClose')