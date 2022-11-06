import Event
from gui.Scaleform.daapi.view.meta.ImageViewMeta import ImageViewMeta
from gui.sounds.filters import switchHangarFilteredFilter
_IMAGE_ROOT_PATH = '../maps/icons/imageView'

class ImageView(ImageViewMeta):
    onImageViewOpened = Event.Event()
    onImageViewClosed = Event.Event()

    def __init__(self, ctx=None):
        super(ImageView, self).__init__(ctx)
        self.__image = ctx['img']

    def _populate(self):
        super(ImageView, self)._populate()
        self.setBgPath()
        switchHangarFilteredFilter(on=True)
        ImageView.onImageViewOpened(self.__image)

    def _dispose(self):
        ImageView.onImageViewClosed(self.__image)

    def onClose(self):
        self.destroy()
        switchHangarFilteredFilter(on=False)

    def setBgPath(self):
        image = ('').join((_IMAGE_ROOT_PATH, '/', self.__image))
        self.flashObject.as_setBgPath(image)