

class ICongratsCtx(object):

    @property
    def background(self):
        raise NotImplementedError

    @property
    def title(self):
        raise NotImplementedError

    @property
    def description(self):
        raise NotImplementedError

    @property
    def image(self):
        raise NotImplementedError

    @property
    def imageAlt(self):
        raise NotImplementedError

    @property
    def confirmLabel(self):
        raise NotImplementedError

    @property
    def backLabel(self):
        raise NotImplementedError

    def onConfirm(self):
        raise NotImplementedError

    def onBack(self):
        raise NotImplementedError