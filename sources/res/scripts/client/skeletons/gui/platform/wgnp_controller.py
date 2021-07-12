import typing
if typing.TYPE_CHECKING:
    from Event import SafeEvent

class IWGNPRequestController(object):
    onEmailConfirmed = None
    onEmailAdded = None
    onEmailAddNeeded = None

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError

    def addEmail(self, email, showWaiting=False):
        raise NotImplementedError

    def getEmailStatus(self, showWaiting=False):
        raise NotImplementedError

    def confirmEmail(self, code, showWaiting=False):
        raise NotImplementedError

    @property
    def emailAddedTime(self):
        raise NotImplementedError