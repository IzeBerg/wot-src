from helpers import aop
import aspects

class MakeClanBtnUnavailable(aop.Pointcut):

    def __init__(self):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.lobby.profile.ProfileSummaryWindow', 'ProfileSummaryWindow', '_getClanBtnParams', aspects=(
         aspects.MakeClanBtnUnavailable(),))


class MakeClubProfileButtonUnavailable(aop.Pointcut):

    def __init__(self):
        aop.Pointcut.__init__(self, 'gui.Scaleform.daapi.view.lobby.profile.ProfileSummaryWindow', 'ProfileSummaryWindow', '_getClubProfileButtonParams', aspects=(
         aspects.MakeClubProfileButtonUnavailable(),))