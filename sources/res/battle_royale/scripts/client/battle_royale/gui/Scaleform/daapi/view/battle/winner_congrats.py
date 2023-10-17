from gui.Scaleform.daapi.view.meta.BattleRoyaleWinnerCongratsMeta import BattleRoyaleWinnerCongratsMeta
from battle_royale.gui.battle_control.controllers.br_battle_sounds import BREvents

class BattleRoyaleWinnerCongrats(BattleRoyaleWinnerCongratsMeta):

    def playWinSound(self):
        BREvents.playSound(BREvents.BATTLE_WIN)