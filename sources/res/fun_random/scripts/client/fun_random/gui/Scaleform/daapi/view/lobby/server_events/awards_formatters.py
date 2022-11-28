from gui.Scaleform.daapi.view.lobby.missions.awards_formatters import CurtailingAwardsComposer, formatShortData
from gui.server_events.awards_formatters import AWARDS_SIZES, AwardsPacker, getLootboxesFormatterMap

class FunCurtailingAwardsComposer(CurtailingAwardsComposer):

    @classmethod
    def _getShortBonusesData(cls, preformattedBonuses, size=AWARDS_SIZES.SMALL):
        return [ formatShortData(bonus, size) for bonus in preformattedBonuses ]


def getFunFormatterMap():
    return getLootboxesFormatterMap()


def getFunAwardsPacker():
    return AwardsPacker(getFunFormatterMap())