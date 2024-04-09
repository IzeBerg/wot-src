

class BattleCommunicationModel(object):
    __slots__ = ('hide', )

    def __init__(self, hide):
        super(BattleCommunicationModel, self).__init__()
        self.hide = hide

    def __repr__(self):
        return '<BattleCommunicationModel>: hide=%s' % self.hide