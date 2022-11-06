from Event import Event

class DisconnectReason(object):
    UNDEFINED = 0
    REQUEST = 1
    EVENT = 2
    KICK = 3
    ERROR = 4


class IConnectionManager(object):
    onLoggedOn = None
    onConnected = None
    onRejected = None
    onDisconnected = None
    onKickedFromServer = None
    onKickWhileLoginReceived = None
    onQueued = None
    onPeripheryRoutingGroupUpdated = None

    @property
    def serverUserName(self):
        raise NotImplementedError

    @property
    def serverUserNameShort(self):
        raise NotImplementedError

    @property
    def peripheryID(self):
        raise NotImplementedError

    @property
    def areaID(self):
        raise NotImplementedError

    @property
    def url(self):
        raise NotImplementedError

    @property
    def loginName(self):
        raise NotImplementedError

    @property
    def lastLoginName(self):
        raise NotImplementedError

    @property
    def databaseID(self):
        raise NotImplementedError

    @property
    def connectionMethod(self):
        raise NotImplementedError

    @property
    def peripheryRoutingGroup(self):
        raise NotImplementedError

    @property
    def availableHosts(self):
        raise NotImplementedError

    def isAvailablePeriphery(self, peripheryID=None):
        raise NotImplementedError

    def initiateConnection(self, params, password, serverName):
        raise NotImplementedError

    def stopRetryConnection(self):
        raise NotImplementedError

    def disconnect(self):
        raise NotImplementedError

    def setKickedFromServer(self, reason, kickReasonType, expiryTime):
        raise NotImplementedError

    def isDisconnected(self):
        raise NotImplementedError

    def isStandalone(self):
        raise NotImplementedError

    def isConnected(self):
        raise NotImplementedError

    def checkClientServerVersions(self, clientVersion, serverVersion):
        raise NotImplementedError

    def setLastLogin(self, email):
        raise NotImplementedError

    def setPeripheryRoutingGroup(self, routingGroup, availableHosts):
        raise NotImplementedError