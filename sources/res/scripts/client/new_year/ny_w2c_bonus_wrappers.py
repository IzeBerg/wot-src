from gui.impl import backport
from gui.impl.gen import R
from gui.server_events.awards_formatters import AWARDS_SIZES
from items.components.ny_constants import CurrentNYConstants
from new_year.ny_toy_info import NewYearCurrentToyInfo
from shared_utils import findFirst
from web.web_client_api.common import sanitizeResPath
from web.web_client_api.loot_boxes import BonusAggregateWrapper

class ToyWrapper(BonusAggregateWrapper):

    @classmethod
    def getWrappedBonus(cls, wrappedToys):
        return {'id': 0, 
           'type': CurrentNYConstants.IP_TYPE_CUSTOM_TOYS, 
           'value': 1, 
           'rank': cls._getToysRank(wrappedToys), 
           'icon': {AWARDS_SIZES.SMALL: sanitizeResPath(backport.image(R.images.gui.maps.icons.newYear.loot_box.rewards.box()))}, 
           'name': '', 
           'description': ''}

    @classmethod
    def _getToysRank(cls, wrappedToys):
        toysRanks = set()
        for toy in wrappedToys:
            if toy['type'] == CurrentNYConstants.IP_TYPE_CUSTOM_ANYOF_TOYS:
                _, _, rank = toy['value'][0]
                toysRanks.add(rank)
            else:
                toysRanks.add(NewYearCurrentToyInfo(toy['value'].keys()[0]).getRank())

        if len(toysRanks) == 1:
            return findFirst(lambda x: x is not None, toysRanks)
        return -1