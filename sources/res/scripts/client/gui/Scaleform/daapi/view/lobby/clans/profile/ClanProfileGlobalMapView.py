from adisp import adisp_process
from gui.Scaleform.daapi.view.lobby.clans.profile.ClanProfileBaseView import ClanProfileBaseView
from gui.Scaleform.genConsts.CLANS_ALIASES import CLANS_ALIASES
from gui.clans.items import isValueAvailable

class ClanProfileGlobalMapView(ClanProfileBaseView):

    @adisp_process
    def setClanDossier(self, clanDossier):
        super(ClanProfileGlobalMapView, self).setClanDossier(clanDossier)
        self._showWaiting()
        clanInfo = yield clanDossier.requestClanInfo()
        if not clanInfo.isValid():
            self._dummyMustBeShown = True
            self._updateDummy()
            self._hideWaiting()
            return
        globalMapStats = yield clanDossier.requestGlobalMapStats()
        if self.isDisposed():
            return
        self._updateClanInfo(clanInfo)
        if isValueAvailable(globalMapStats.hasGlobalMap):
            if globalMapStats.hasGlobalMap():
                linkage = CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_INFO_VIEW_LINKAGE
            else:
                linkage = CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_PROMO_VIEW_LINKAGE
            self.as_setDataS(linkage)
        else:
            self._dummyMustBeShown = True
            self._updateDummy()
        self._updateHeaderState()
        self._hideWaiting()

    def showWaiting(self):
        self._showWaiting()

    def hideWaiting(self):
        self._hideWaiting()

    def _onRegisterFlashComponent(self, viewPy, alias):
        if alias == CLANS_ALIASES.CLAN_PROFILE_GLOBALMAP_INFO_VIEW_ALIAS:
            viewPy.setProxy(self, self._clanDossier)