from frameworks.wulf.view.view import View, ViewSettings
from gui.impl.gen.resources import R
from gui.impl.gen.view_models.views.lobby.new_year.tooltips.new_year_collections_tooltip_content_model import NewYearCollectionsTooltipContentModel
from helpers import dependency
from new_year.collection_presenters import CurrentNYCollectionPresenter
from skeletons.gui.shared import IItemsCache

class NewYearCollectionsTooltipContent(View):
    _itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.new_year_collections_tooltip_content.NYCollectionsTooltipContent())
        settings.model = NewYearCollectionsTooltipContentModel()
        super(NewYearCollectionsTooltipContent, self).__init__(settings)

    @property
    def viewModel(self):
        return super(NewYearCollectionsTooltipContent, self).getViewModel()

    def _initialize(self, *args, **kwargs):
        super(NewYearCollectionsTooltipContent, self)._initialize()
        toys = str(CurrentNYCollectionPresenter.getCount())
        allToys = str(CurrentNYCollectionPresenter.getTotalCount())
        self.viewModel.setCurrentToysCount(toys)
        self.viewModel.setAllToysCount(allToys)