from gui.Scaleform.framework import ScopeTemplates
from gui.Scaleform.framework.managers.loaders import GuiImplViewLoadParams
from gui.Scaleform.framework.view_overrider import OverrideData
from gui.impl.gen import R
from halloween.gui.impl.lobby.pre_battle_queue_view import PreBattleQueueView
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency

class BattleQueueOverride(OverrideData):
    __hwController = dependency.descriptor(IHalloweenController)

    def __init__(self):
        super(BattleQueueOverride, self).__init__(GuiImplViewLoadParams(R.views.halloween.lobby.PreBattleQueueView(), PreBattleQueueView, ScopeTemplates.LOBBY_SUB_SCOPE))

    def checkCondition(self, *args, **kwargs):
        return self.__hwController.isEventHangar()