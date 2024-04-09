

class ProgressCounterClientModel(object):
    __slots__ = ('id', 'header', 'icon')

    def __init__(self, id, header, icon):
        super(ProgressCounterClientModel, self).__init__()
        self.id = id
        self.header = header
        self.icon = icon

    def __repr__(self):
        return '<ProgressCounterClientModel>: id=%s, header=%s, icon=%s' % (
         self.id, self.header, self.icon)