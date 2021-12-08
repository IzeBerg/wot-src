import logging, typing
from gui.shared.utils import getPlayerDatabaseID
from helpers import getClientVersion
_logger = logging.getLogger(__name__)

def createFeatureKey(feature, group):
    return feature


def getPlayerID():
    playerID = getPlayerDatabaseID()
    if not playerID:
        _logger.warning('Player id not available or player is bot.')
        return
    return playerID


def getClientBuildVersion():
    return getClientVersion(force=False)