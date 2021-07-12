

class IHangarSpacesSwitcher(object):

    def init(self):
        raise NotImplementedError

    def destroy(self):
        raise NotImplementedError

    @property
    def itemsToSwitch(self):
        raise NotImplementedError

    @property
    def currentItem(self):
        raise NotImplementedError