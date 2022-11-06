from frameworks.wulf import ViewFlags, ViewSettings
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.premacc.daily_experience_view_model import DailyExperienceViewModel
from gui.impl.lobby.premacc.daily_experience_base import DailyExperienceBaseView
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.shared import events
from gui.shared.event_dispatcher import showTankPremiumAboutPage

def getBackBtnLabel(_=None):
    return R.strings.premacc.dailyExperiencePage.backBtnAddLabel()


class DailyExperienceView(DailyExperienceBaseView):
    __slots__ = ('__exitEvent', )

    def __init__(self, layoutID, ctx=None):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_TOP_SUB_VIEW
        settings.model = DailyExperienceViewModel()
        super(DailyExperienceView, self).__init__(settings)
        self.__exitEvent = ctx.get('exitEvent') if ctx is not None else events.LoadViewEvent(SFViewLoadParams(VIEW_ALIAS.LOBBY_HANGAR))
        return

    def _initialize(self, *args, **kwargs):
        super(DailyExperienceView, self)._initialize(*args, **kwargs)
        with self.getViewModel().transaction() as (model):
            model.setBackBtnLabel(getBackBtnLabel(self.__exitEvent))

    def _finalize(self):
        self.__exitEvent = None
        super(DailyExperienceView, self)._finalize()
        return

    def _addListeners(self):
        super(DailyExperienceView, self)._addListeners()
        self.viewModel.onGoToContentPage += self.__onShowMoreInfo
        self.viewModel.onBackBtnClicked += self.__onBackBtnClicked

    def _removeListeners(self):
        self.viewModel.onGoToContentPage -= self.__onShowMoreInfo
        self.viewModel.onBackBtnClicked -= self.__onBackBtnClicked
        super(DailyExperienceView, self)._removeListeners()

    def __onShowMoreInfo(self, args=None):
        showTankPremiumAboutPage()

    def __onBackBtnClicked(self, _=None):
        self.destroyWindow()