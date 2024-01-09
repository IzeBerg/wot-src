import BigWorld
from gui.Scaleform.daapi.view.lobby.battle_queue import RandomQueueProvider
from gui.Scaleform.locale.MENU import MENU
from helpers.i18n import makeString

class EpicQueueProvider(RandomQueueProvider):

    def forceStart(self):
        currPlayer = BigWorld.player()
        if currPlayer is not None:
            currPlayer.FLAccountComponent.forceEpicDevStart()
        return

    def getTankInfoLabel(self):
        return makeString(MENU.PREBATTLE_STARTINGTANKLABEL)