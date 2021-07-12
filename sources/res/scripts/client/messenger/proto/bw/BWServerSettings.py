from messenger.proto.interfaces import IProtoSettings

class BWServerSettings(IProtoSettings):

    def isEnabled(self):
        return True