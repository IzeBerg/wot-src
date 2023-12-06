from gui.impl.lobby.new_year.sub_model_presenter import SubModelPresenter

class RewardsSubModelPresenter(SubModelPresenter):
    __slots__ = ()

    def update(self, *args, **kwargs):
        raise NotImplementedError()

    def getInfoForHistory(self):
        return dict()