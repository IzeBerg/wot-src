from gui.gift_system.hubs.base.relations_keeper import GiftEventBaseKeeper
from gui.gift_system.hubs.base.relations_keeper import IGiftEventKeeper

class IGiftEventNYKeeper(IGiftEventKeeper):

    def isFullfilled(self, spaID):
        raise NotImplementedError


class GiftEventNYKeeper(GiftEventBaseKeeper, IGiftEventNYKeeper):
    __slots__ = ()

    def isFullfilled(self, spaID):
        outcomeRelations = self.getOutcomeRelations(implicitCopy=False)
        return spaID in outcomeRelations and outcomeRelations[spaID]