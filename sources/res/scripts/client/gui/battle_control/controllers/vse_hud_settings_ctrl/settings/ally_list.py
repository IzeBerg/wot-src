

class AllyListClientModel(object):
    __slots__ = ('showFrags', 'showVehicleTypeIcon', 'highlightElite')

    def __init__(self, showFrags, showVehicleTypeIcon, highlightElite):
        super(AllyListClientModel, self).__init__()
        self.showFrags = showFrags
        self.showVehicleTypeIcon = showVehicleTypeIcon
        self.highlightElite = highlightElite

    def __repr__(self):
        return '<AllyListClientModel>: showFrags=%s, showVehicleTypeIcon=%s, highlightElite=%s' % (
         self.showFrags, self.showVehicleTypeIcon, self.highlightElite)