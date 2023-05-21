from collections import namedtuple
from season_common import GameSeason

class BattleRoyaleCycle(namedtuple('BattleRoyaleCycle', 'ID, status, startDate, endDate, ordinalNumber, announceOnly')):

    def __cmp__(self, other):
        return cmp(self.ID, other.ID)

    def getUserName(self):
        return str(self.ordinalNumber)

    def getEpicCycleNumber(self):
        return self.ordinalNumber


class BattleRoyaleSeason(GameSeason):

    def _buildCycle(self, idx, status, number, rawData):
        return BattleRoyaleCycle(idx, status, rawData['start'], rawData['end'], number, bool(rawData.get('announce', False)))