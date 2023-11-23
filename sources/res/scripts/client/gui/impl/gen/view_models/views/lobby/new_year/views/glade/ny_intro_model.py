from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.region_model import RegionModel
from gui.impl.gen.view_models.views.lobby.new_year.components.video_cover_model import VideoCoverModel

class NyIntroModel(ViewModel):
    __slots__ = ('onClose', 'showBlur')

    def __init__(self, properties=2, commands=2):
        super(NyIntroModel, self).__init__(properties=properties, commands=commands)

    @property
    def videoCover(self):
        return self._getViewModel(0)

    @staticmethod
    def getVideoCoverType():
        return VideoCoverModel

    @property
    def region(self):
        return self._getViewModel(1)

    @staticmethod
    def getRegionType():
        return RegionModel

    def _initialize(self):
        super(NyIntroModel, self)._initialize()
        self._addViewModelProperty('videoCover', VideoCoverModel())
        self._addViewModelProperty('region', RegionModel())
        self.onClose = self._addCommand('onClose')
        self.showBlur = self._addCommand('showBlur')