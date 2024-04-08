

class ChatModel(object):
    __slots__ = ('hide', )

    def __init__(self, hide):
        super(ChatModel, self).__init__()
        self.hide = hide

    def __repr__(self):
        return '<ChatModel>: hide=%s' % self.hide