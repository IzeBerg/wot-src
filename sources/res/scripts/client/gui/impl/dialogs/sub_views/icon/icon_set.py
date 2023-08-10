import typing
from gui.impl.gen import R
from gui.impl.gen.view_models.views.dialogs.sub_views.icon_set_view_model import IconSetViewModel, IconPositionLogicEnum
from gui.impl.gen.view_models.views.dialogs.sub_views.icon_view_model import IconViewModel
from gui.impl.gen_utils import INVALID_RES_ID
from gui.impl.pub import ViewImpl
from frameworks.wulf import ViewSettings
if typing.TYPE_CHECKING:
    from typing import List, Optional
    from frameworks.wulf import Array

def _addIconResIdsToViewModelArray(source, target):
    if source:
        for resID in source:
            if resID != INVALID_RES_ID:
                iconVM = IconViewModel()
                iconVM.setPath(resID)
                target.addViewModel(iconVM)


class IconSet(ViewImpl):
    __slots__ = ()

    def __init__(self, iconResID, backgroundResIDList=None, overlayResIDList=None, layoutID=None, iconPositionLogic=IconPositionLogicEnum.CENTREDANDTHROUGHCONTENT.value, imageUrl=''):
        settings = ViewSettings(layoutID or R.views.dialogs.sub_views.icon.IconSet())
        settings.model = IconSetViewModel()
        settings.kwargs = {'iconResID': iconResID, 
           'backgroundResIDList': backgroundResIDList, 
           'overlayResIDList': overlayResIDList, 
           'iconPositionLogic': iconPositionLogic}
        if imageUrl:
            settings.kwargs['imageUrl'] = imageUrl
        super(IconSet, self).__init__(settings)

    def _onLoading(self, iconResID, backgroundResIDList, overlayResIDList, iconPositionLogic, *args, **kwargs):
        super(IconSet, self)._onLoading(*args, **kwargs)
        viewModel = self.getViewModel()
        viewModel.setIconPositionLogic(iconPositionLogic)
        if iconResID != INVALID_RES_ID:
            viewModel.icon.setPath(iconResID)
        imageUrl = kwargs.get('imageUrl')
        if imageUrl:
            viewModel.icon.setUrl(imageUrl)
        _addIconResIdsToViewModelArray(backgroundResIDList, viewModel.getBackgrounds())
        _addIconResIdsToViewModelArray(overlayResIDList, viewModel.getOverlays())