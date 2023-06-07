from gui import GUI_SETTINGS
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache
REF_RPOGRAM_PDATA_KEY = 'refProgram'
RECRUITER_ID_ATTR = 'recruiterId'

def _getUrl(urlName=None):
    if urlName is None:
        return getReferralProgramURL()
    else:
        return getReferralProgramURL() + GUI_SETTINGS.referralProgram.get(urlName)


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def isReferralProgramEnabled(lobbyContext=None):
    return lobbyContext and lobbyContext.getServerSettings().isReferralProgramEnabled()


def getReferralProgramURL():
    return GUI_SETTINGS.referralProgram.get('baseUrl')


def getObtainVehicleURL():
    return _getUrl('getVehicle')


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def isCurrentUserRecruit(itemsCache=None):
    return bool(itemsCache.items.stats.refSystem20.get(RECRUITER_ID_ATTR, False))