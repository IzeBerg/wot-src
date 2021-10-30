import types
from messenger.storage.local_cache import SimpleCachedStorage

class ShownMessagesStorage(SimpleCachedStorage):
    __slots__ = ('__channelShownMessageIDs', )

    def __init__(self):
        super(ShownMessagesStorage, self).__init__()
        self.__channelShownMessageIDs = {}

    def __repr__(self):
        return ('ShownMessagesStorage(id=0x{0:08X})').format(id(self))

    def clear(self):
        self.__channelShownMessageIDs.clear()
        super(ShownMessagesStorage, self).clear()

    def getMessages(self, channelID):
        if channelID in self.__channelShownMessageIDs:
            return self.__channelShownMessageIDs[channelID]
        return []

    def setMessages(self, channelID, messageIDs):
        self.__channelShownMessageIDs[channelID] = messageIDs

    def _getCachedData(self):
        return list([ (jid, self.__channelShownMessageIDs[jid]) for jid in self.__channelShownMessageIDs ])

    def _setCachedData(self, data):
        self.__channelShownMessageIDs = {}
        if data:
            for item in data:
                if not isinstance(item, types.TupleType):
                    continue
                if len(item) != 2:
                    continue
                channelID, shownMessageIDs = item
                self.__channelShownMessageIDs[channelID] = shownMessageIDs