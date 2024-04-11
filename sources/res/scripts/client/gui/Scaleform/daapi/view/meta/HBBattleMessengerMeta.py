from messenger.gui.Scaleform.view.battle.messenger_view import BattleMessengerView

class HBBattleMessengerMeta(BattleMessengerView):

    def as_toggleReadingModerS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_toggleReadingModer(value)