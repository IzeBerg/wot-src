from frameworks.wulf.view.submodel_presenter import SubModelPresenter

class SubViewBase(SubModelPresenter):
    __slots__ = ()

    @property
    def viewId(self):
        raise NotImplementedError