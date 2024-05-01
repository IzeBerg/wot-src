import logging, typing
from constants import LOOTBOX_TOKEN_PREFIX
from cosmic_event.cosmic_constants import PROGRESSION_POINT
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from gui.impl import backport
from gui.impl.auxiliary.collections_helper import TmanTemplateBonusPacker
from gui.impl.backport import createTooltipData
from gui.impl.gen import R
from gui.impl.gen.view_models.common.missions.bonuses.token_bonus_model import TokenBonusModel
from gui.server_events.formatters import parseComplexToken
from gui.server_events.recruit_helper import getRecruitInfo
from gui.shared.missions.packers.bonus import BonusUIPacker, TokenBonusUIPacker, getDefaultBonusPackersMap, BACKPORT_TOOLTIP_CONTENT_ID
from gui.shared.missions.packers.events import DailyQuestUIDataPacker
from gui.shared.utils.functions import makeTooltip
from helpers import dependency
from items.tankmen import RECRUIT_TMAN_TOKEN_PREFIX
from gui.impl.gen.view_models.views.lobby.collection.reward_model import RewardModel
if typing.TYPE_CHECKING:
    from typing import List, Dict, Callable, TypeVar, Optional
    from gui.server_events.formatters import TokenComplex
    from gui.server_events.bonuses import TokensBonus
    TokenBonusType = TypeVar('TokenBonusType', bound=TokensBonus)
    from gui.impl.backport import TooltipData
_logger = logging.getLogger(__name__)

class CosmicTokenBonusUIPacker(TokenBonusUIPacker):

    @classmethod
    def _getTokenBonusType(cls, tokenID, complexToken):
        battleController = dependency.instance(ICosmicEventBattleController)
        if tokenID == battleController.getTokenProgressionID() or tokenID == battleController.getArtifactToken():
            return tokenID
        if tokenID.startswith(LOOTBOX_TOKEN_PREFIX):
            return LOOTBOX_TOKEN_PREFIX
        return super(CosmicTokenBonusUIPacker, cls)._getTokenBonusType(tokenID, complexToken)

    @classmethod
    def _getTooltipsPackers(cls):
        battleController = dependency.instance(ICosmicEventBattleController)
        tooltips = super(CosmicTokenBonusUIPacker, cls)._getTooltipsPackers()
        tooltips.update({battleController.getTokenProgressionID(): cls._getCosmicToolTip, 
           battleController.getArtifactToken(): cls._getArtifactTokenTooltip, 
           LOOTBOX_TOKEN_PREFIX: cls._getLootTooltip})
        return tooltips

    @classmethod
    def _getTokenBonusPackers(cls):
        battleController = dependency.instance(ICosmicEventBattleController)
        packers = super(CosmicTokenBonusUIPacker, cls)._getTokenBonusPackers()
        packers.update({battleController.getTokenProgressionID(): cls._packCosmicToken, 
           LOOTBOX_TOKEN_PREFIX: cls._packLootboxToken, 
           battleController.getArtifactToken(): cls._packArtifactToken})
        return packers

    @classmethod
    def _getContentId(cls, bonus):
        bonusTokens = bonus.getTokens()
        result = []
        for tokenID, _ in bonusTokens.iteritems():
            complexToken = parseComplexToken(tokenID)
            tokenType = cls._getTokenBonusType(tokenID, complexToken)
            if tokenType == LOOTBOX_TOKEN_PREFIX:
                result.append(R.views.event_lootboxes.lobby.event_lootboxes.tooltips.LootBoxesTooltip())
            else:
                result.append(BACKPORT_TOOLTIP_CONTENT_ID)

        return result

    @classmethod
    def _packCosmicToken(cls, model, bonus, *args):
        progressionController = dependency.instance(ICosmicEventProgressionController)
        if progressionController.isProgressionFinished():
            return None
        else:
            return cls.__packCosmicTokenCommon(model, bonus, PROGRESSION_POINT)

    @classmethod
    def _packLootboxToken(cls, model, bonus, *args):
        model = cls.__packCosmicTokenCommon(model, bonus, 'cosmic_lootbox')
        model.setLabel(backport.text(R.strings.quests.bonusName.cosmic_lootbox()))
        return model

    @classmethod
    def _packArtifactToken(cls, model, bonus, *args):
        model.setLabel(backport.text(R.strings.cosmicEvent.lobby.progress.antimatter_tooltip.title()))
        return cls.__packCosmicTokenCommon(model, bonus, 'fragment_antimatter')

    @classmethod
    def __packCosmicTokenCommon(cls, model, bonus, name):
        model.setName(name)
        model.setValue(str(bonus.getCount()))
        return model

    @classmethod
    def _getCosmicToolTip(cls, *_):
        return makeTooltip(header=backport.text(R.strings.cosmicEvent.tooltip.cosmicPoints.header()), body=backport.text(R.strings.cosmicEvent.tooltip.cosmicPoints.description()))

    @classmethod
    def _getArtifactTokenTooltip(cls, *_):
        tooltip = makeTooltip(header=backport.text(R.strings.cosmicEvent.lobby.progress.antimatter_tooltip.title()), body=backport.text(R.strings.cosmicEvent.lobby.progress.antimatter_tooltip.description()))
        return createTooltipData(tooltip)

    @classmethod
    def _getLootTooltip(cls, *_):
        return


class CosmicProgressionTokenBonusUIPacker(CosmicTokenBonusUIPacker):

    @classmethod
    def _packArtifactToken(cls, model, bonus, *args):
        return


class CosmicTmanTemplateBonusPacker(TmanTemplateBonusPacker):

    @classmethod
    def _pack(cls, bonus):
        result = []
        for tokenID in bonus.getTokens().keys():
            if tokenID.startswith(RECRUIT_TMAN_TOKEN_PREFIX):
                packed = cls.__packTmanTemplateToken(tokenID, bonus)
                if packed is not None:
                    result.append(packed)

        return result

    @classmethod
    def __packTmanTemplateToken(cls, tokenID, bonus):
        recruitInfo = getRecruitInfo(tokenID)
        if recruitInfo is None:
            return
        else:
            model = RewardModel()
            cls._packCommon(bonus, model)
            imageName = recruitInfo.getGroupName()
            if '_' in imageName:
                imageName = imageName.split('_')[1].lower()
            else:
                imageName = 'tankwoman' if recruitInfo.isFemale() else 'tankman'
            model.setIcon(imageName)
            model.setLabel(recruitInfo.getFullUserName())
            return model


def getCosmicBonusPacker(forProgression=False):
    mapping = getDefaultBonusPackersMap()
    mapping.update({'battleToken': CosmicProgressionTokenBonusUIPacker() if forProgression else CosmicTokenBonusUIPacker(), 
       'tmanToken': CosmicTmanTemplateBonusPacker()})
    return BonusUIPacker(mapping)


class DailyCosmicQuestUIDataPacker(DailyQuestUIDataPacker):

    def _getBonusPacker(self):
        return getCosmicBonusPacker()