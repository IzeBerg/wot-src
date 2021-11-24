import logging
from gui.impl import backport
from helpers import dependency, time_utils
from skeletons.gui.lobby_context import ILobbyContext
from helpers.time_utils import getServerUTCTime
_logger = logging.getLogger(__name__)

@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getSeniorityAwardsAutoOpenDate(lobbyContext=None):
    config = lobbyContext.getServerSettings().getSeniorityAwardsConfig()
    autoOpenTime = config.autoOpenTimestamp()
    autoOpenLocalTime = time_utils.makeLocalServerTime(autoOpenTime)
    return backport.getLongDateFormat(autoOpenLocalTime)


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def autoOpenTimeExpired(lobbyContext=None):
    config = lobbyContext.getServerSettings().getSeniorityAwardsConfig()
    autoOpenTime = config.autoOpenTimestamp()
    return autoOpenTime < getServerUTCTime()