from gui.Scaleform.daapi.view.lobby.battle_queue import RandomQueueProvider

class RacesQueueProvider(RandomQueueProvider):

    def processQueueInfo(self, qInfo):
        count = qInfo.get('players', 0)
        self._proxy.setPlayersCount(count)

    def _createCommonPlayerString(self, playerCount):
        pass