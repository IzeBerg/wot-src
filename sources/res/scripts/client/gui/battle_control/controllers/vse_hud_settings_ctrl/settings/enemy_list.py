

class EnemyListClientModel(object):
    __slots__ = ('showSpottedIcon', 'highlightElite')

    def __init__(self, showSpottedIcon, highlightElite):
        super(EnemyListClientModel, self).__init__()
        self.showSpottedIcon = showSpottedIcon
        self.highlightElite = highlightElite

    def __repr__(self):
        return '<EnemyListClientModel>: showSpottedIcon=%s, highlightElite=%s' % (
         self.showSpottedIcon, self.highlightElite)