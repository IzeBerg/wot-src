import typing
from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.server_events.awards_formatters import AWARDS_SIZES
from halloween.gui.game_control.halloween_artefacts_controller import compareBonusesByPriority
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.gen.view_models.views.lobby.tooltips.event_mission_tooltip_view_model import EventMissionTooltipViewModel
from halloween.gui.impl.lobby import getArtefactState
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import HalloweenBonusesAwardsComposer, getImgName, getHWMetaAwardFormatter
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency
if typing.TYPE_CHECKING:
    from halloween.gui.game_control.halloween_artefacts_controller import Artefact

class EventMissionsTooltip(ViewImpl):
    __slots__ = ('__selectedArtefactID', '__isHangar')
    _hwArtefactsCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _hwController = dependency.descriptor(IHalloweenController)
    _MAX_BONUSES_IN_VIEW = 5

    def __init__(self, selectedArtefactID, isHangar):
        settings = ViewSettings(R.views.halloween.lobby.tooltips.EventMissionTooltip())
        settings.model = EventMissionTooltipViewModel()
        super(EventMissionsTooltip, self).__init__(settings)
        self.__selectedArtefactID = selectedArtefactID
        self.__isHangar = isHangar

    @property
    def viewModel(self):
        return super(EventMissionsTooltip, self).getViewModel()

    def _onLoading(self):
        super(EventMissionsTooltip, self)._onLoading()
        artefact = self._hwArtefactsCtrl.getArtefact(self.__selectedArtefactID)
        finalArtefact = self._hwArtefactsCtrl.getFinalArtefact()
        if artefact is None:
            return
        else:
            with self.viewModel.transaction() as (tx):
                tx.setIsHangar(self.__isHangar)
                tx.setSkipPrice(artefact.skipPrice.amount)
                tx.setDecodePrice(artefact.decodePrice.amount)
                tx.setId(self.__selectedArtefactID)
                tx.setIndex(self._hwArtefactsCtrl.getIndex(artefact.artefactID))
                tx.setName(artefact.questConditions.name)
                tx.setRegularArtefactCount(self._hwArtefactsCtrl.getMaxArtefactsProgress())
                tx.setEndDate(int(self._hwController.getModeSettings().endDate))
                tx.setState(getArtefactState(self.__selectedArtefactID))
                tx.setIsKingReward(artefact.artefactID == finalArtefact.artefactID)
                rewardsVM = tx.getRewards()
                bonusRewards = artefact.bonusRewards
                formatter = HalloweenBonusesAwardsComposer(self._MAX_BONUSES_IN_VIEW, getHWMetaAwardFormatter())
                sortedBonuses = sorted(bonusRewards, cmp=compareBonusesByPriority)
                bonusRewards = formatter.getFormattedBonuses(sortedBonuses, AWARDS_SIZES.BIG)
                for bonus in bonusRewards:
                    if self._hwArtefactsCtrl.getIsHiddenBonusStyle(bonus):
                        continue
                    reward = BonusItemViewModel()
                    reward.setUserName(str(bonus.userName))
                    reward.setName(bonus.bonusName)
                    reward.setValue(str(bonus.label))
                    reward.setLabel(str(bonus.label))
                    reward.setIcon(getImgName(bonus.getImage(AWARDS_SIZES.BIG)))
                    reward.setOverlayType(bonus.getOverlayType(AWARDS_SIZES.SMALL))
                    rewardsVM.addViewModel(reward)

            return