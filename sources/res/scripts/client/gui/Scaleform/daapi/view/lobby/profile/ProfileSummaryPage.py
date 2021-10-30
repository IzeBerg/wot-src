from gui.Scaleform.daapi.view.lobby.profile.ProfileSummary import ProfileSummary
from gui.Scaleform.locale.PROFILE import PROFILE

class ProfileSummaryPage(ProfileSummary):

    def __init__(self, *args):
        ProfileSummary.__init__(self, *args)

    def _getInitData(self):
        outcome = ProfileSummary._getInitData(self)
        outcome['nextAwardsLabel'] = PROFILE.SECTION_SUMMARY_LABELS_NEXTAWARDS
        outcome['nextAwardsErrorText'] = PROFILE.SECTION_SUMMARY_ERRORTEXT_NEXTAWARDS
        return outcome

    def getGlobalRating(self, userName):
        return self.itemsCache.items.stats.globalRating