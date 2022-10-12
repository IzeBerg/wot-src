from frameworks.wulf.view.submodel_presenter import SubModelPresenter

class PageSubModelPresenter(SubModelPresenter):
    __slots__ = ()

    @property
    def pageId(self):
        raise NotImplementedError