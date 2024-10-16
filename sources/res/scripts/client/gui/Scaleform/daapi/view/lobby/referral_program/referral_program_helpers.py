from gui import GUI_SETTINGS
from helpers import dependency
from skeletons.gui.shared import IItemsCache
RECRUITER_SPA_ID_ATTR = '/wot/game/ref/recruiterSpaId'

def _getUrl(urlName=None):
    if urlName is None:
        return getReferralProgramURL()
    else:
        return getReferralProgramURL() + GUI_SETTINGS.referralProgram.get(urlName)


def getReferralProgramURL():
    return GUI_SETTINGS.referralProgram.get('baseUrl')


def getObtainVehicleURL():
    return _getUrl('getVehicle')


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def isCurrentUserRecruit(itemsCache=None):
    return bool(itemsCache.items.stats.SPA.get(RECRUITER_SPA_ID_ATTR, False))