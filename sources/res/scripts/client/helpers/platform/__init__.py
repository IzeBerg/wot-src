import typing
from constants import WGC_PUBLICATION
from helpers import dependency
from helpers.platform.base import BasePublishPlatform
from helpers.platform.steam import SteamPublishPlatform
from skeletons.gui.login_manager import ILoginManager
if typing.TYPE_CHECKING:
    from skeletons.helpers.platform import IPublishPlatform
_MAPPING = {WGC_PUBLICATION.WGC_STEAM: SteamPublishPlatform}

@dependency.replace_none_kwargs(loginManager=ILoginManager)
def getPublishPlatform(loginManager=None):
    pub = loginManager.getWgcPublication()
    if pub in _MAPPING:
        return _MAPPING[pub]()
    return BasePublishPlatform()