import logging, typing
from gui.impl.gen.view_models.views.lobby.comp7.meta_view.progression_division import Division, State
from gui.impl.gen.view_models.views.lobby.comp7.meta_view.progression_division import ProgressionDivision
from gui.impl.gen.view_models.views.lobby.comp7.meta_view.progression_item_base_model import Rank
from helpers import dependency
from intervals import Interval
from skeletons.gui.game_control import IComp7Controller
from skeletons.gui.lobby_context import ILobbyContext
from gui.impl.lobby.comp7 import comp7_shared
if typing.TYPE_CHECKING:
    from comp7_ranks_common import Comp7Division
    from gui.impl.gen.view_models.views.lobby.comp7.meta_view.progression_base_model import ProgressionBaseModel
    from gui.impl.gen.view_models.views.lobby.comp7.meta_view.progression_item_base_model import ProgressionItemBaseModel
    from helpers.server_settings import Comp7PrestigeRanksConfig
_logger = logging.getLogger(__name__)

def setProgressionItemData(itemModel, parentModel, rankIdx, ranksConfig):
    setRankData(itemModel, parentModel, rankIdx, ranksConfig)
    setDivisionData(itemModel, getRankDivisions(rankIdx, ranksConfig))


@dependency.replace_none_kwargs(comp7Controller=IComp7Controller)
def setRankData(itemModel, parentModel, rankIdx, ranksConfig, comp7Controller=None):
    sortedDivisions = getRankDivisions(rankIdx, ranksConfig)
    rankLimits = Interval(sortedDivisions[0].range.begin, sortedDivisions[(-1)].range.end)
    isRankElite = rankIdx == _getEliteRank()
    if not isRankElite or comp7Controller.isElite:
        if comp7Controller.rating in rankLimits:
            parentModel.setCurrentItemIndex(rankIdx)
    itemModel.setRank(comp7_shared.getRankEnumValue(sortedDivisions[0]))
    itemModel.setFrom(rankLimits.begin)
    itemModel.setTo(rankLimits.end + 1)


def getRankDivisions(rankIdx, ranksConfig):
    if len(ranksConfig.ranksOrder) != len(Rank):
        _logger.error('Config/ enum ranks length mismatch')
    sortedDivisions = ranksConfig.divisionsByRank[rankIdx]
    if len(sortedDivisions) > len(Division):
        _logger.error('Config/ enum divisions length mismatch')
    return sortedDivisions


def setDivisionData(itemModel, divisions):
    divisionsArray = itemModel.getDivisions()
    divisionsArray.clear()
    for division in divisions:
        divisionModel = ProgressionDivision()
        divisionModel.setName(comp7_shared.getDivisionEnumValue(division))
        divisionModel.setState(getDivisionState(division))
        divisionsArray.addViewModel(divisionModel)

    divisionsArray.invalidate()


@dependency.replace_none_kwargs(comp7Controller=IComp7Controller)
def getDivisionState(division, comp7Controller=None):
    eliteRank = _getEliteRank()
    if division.rank == eliteRank and not comp7Controller.isElite:
        return State.INACTIVE
    currentRating = comp7Controller.rating
    if division.range.begin <= currentRating:
        if currentRating <= division.range.end:
            return State.CURRENT
        return State.ACHIEVED
    return State.INACTIVE


@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def _getEliteRank(lobbyCtx=None):
    ranksConfig = lobbyCtx.getServerSettings().comp7PrestigeRanksConfig
    eliteRank = len(ranksConfig.ranksOrder) - 1
    return eliteRank