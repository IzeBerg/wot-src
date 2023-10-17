import types, logging
from chat_shared import SYS_MESSAGE_TYPE
from gui.SystemMessages import SM_TYPE
from gui.shared.notifications import NotificationPriorityLevel
from helpers import dependency
from gui.game_control.AwardController import ServiceChannelHandler
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.gui.shared.event_dispatcher import showDifficultyView, showRewardWindowView, showKingRewardCongratsView
from skeletons.gui.impl import IGuiLoader
from gui.impl.gen import R
from gui import SystemMessages
from frameworks.wulf import WindowStatus
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.gui.halloween_gui_constants import DifficultyLevel
from halloween.gui.halloween_account_settings import AccountSettingsKeys
from halloween.gui import halloween_account_settings
_logger = logging.getLogger(__name__)

class HWArtefactAwardWindowHandler(ServiceChannelHandler):
    hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)

    def __init__(self, awardCtrl):
        super(HWArtefactAwardWindowHandler, self).__init__(SYS_MESSAGE_TYPE.hwArtefactRewardCongrats.index(), awardCtrl)

    def _needToShowAward(self, ctx):
        if not super(HWArtefactAwardWindowHandler, self)._needToShowAward(ctx):
            return False
        else:
            _, msg = ctx
            if msg is not None and isinstance(msg.data, types.DictType):
                tokenID = msg.data.get('tokenID')
                if tokenID is not None:
                    return True
            return False

    def _showAward(self, ctx):
        _, message = ctx
        tokenID = message.data.get('tokenID')
        artefactID = self.hwArtifactsCtrl.geArtefactIDFromOpenToken(tokenID)
        if self._isKingRewardToken(tokenID):
            showKingRewardCongratsView(artefactID, isVideoInLastArtefact=True, useQueue=True)
        else:
            showRewardWindowView(artefactID, useQueue=True)

    def _isKingRewardToken(self, token):
        artefact = self.hwArtifactsCtrl.getArtefact(self.hwArtifactsCtrl.geArtefactIDFromOpenToken(token))
        return self.hwArtifactsCtrl.isFinalArtefact(artefact)


class HWDifficultyAwardWindowHandler(ServiceChannelHandler):
    difficultyCtrl = dependency.descriptor(IDifficultyLevelController)
    hwController = dependency.descriptor(IHalloweenController)
    guiLoader = dependency.descriptor(IGuiLoader)

    def __init__(self, awardCtrl):
        super(HWDifficultyAwardWindowHandler, self).__init__(SYS_MESSAGE_TYPE.hwDifficultyRewardCongrats.index(), awardCtrl)
        self.__battleResultsWindowID = None
        return

    def _needToShowAward(self, ctx):
        if self.hwController.isEventHangar() and not self.__checkBattleResultOpened():
            return True
        self.guiLoader.windowsManager.onWindowStatusChanged += self.__onWindowStatusChanged
        return False

    def _showAward(self, ctx):
        for item in self.difficultyCtrl.getLevelsInfo():
            if item.level == DifficultyLevel.EASY or not item.isUnlock:
                continue
            if item.level.value not in halloween_account_settings.getSettings(AccountSettingsKeys.UNLOCK_LEVELS):
                showDifficultyView(item.level.value, useQueue=True)
                SystemMessages.pushMessage('', type=SM_TYPE.hwDifficultyOpenMessage, priority=NotificationPriorityLevel.MEDIUM)
                halloween_account_settings.setUnlockedLevel(item.level.value)
                return

    def __checkBattleResultOpened(self):
        battleResults = self.guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.lobby.BattleResultView())
        if battleResults is not None:
            self.__battleResultsWindowID = battleResults.getParentWindow().uniqueID
        return self.__battleResultsWindowID is not None

    def __onWindowStatusChanged(self, uniqueID, newState):
        if newState == WindowStatus.LOADED:
            window = self.guiLoader.windowsManager.getWindow(uniqueID)
            if window.content is None:
                return
            from halloween.gui.impl.lobby.hangar_view import HangarView
            if isinstance(window.content, HangarView):
                self.__handleWindowStatus()
        elif newState == WindowStatus.DESTROYED:
            if uniqueID == self.__battleResultsWindowID:
                self.__handleWindowStatus()
        return

    def __handleWindowStatus(self):
        self.__battleResultsWindowID = None
        self.guiLoader.windowsManager.onWindowStatusChanged -= self.__onWindowStatusChanged
        self.handle(None)
        return