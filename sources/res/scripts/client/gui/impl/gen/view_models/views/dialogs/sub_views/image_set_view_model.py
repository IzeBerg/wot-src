from gui.impl.gen.view_models.views.dialogs.sub_views.icon_set_view_model import IconSetViewModel
from gui.impl.gen.view_models.views.dialogs.sub_views.image_view_model import ImageViewModel

class ImageSetViewModel(IconSetViewModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(ImageSetViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def image(self):
        return self._getViewModel(4)

    @staticmethod
    def getImageType():
        return ImageViewModel

    def _initialize(self):
        super(ImageSetViewModel, self)._initialize()
        self._addViewModelProperty('image', ImageViewModel())