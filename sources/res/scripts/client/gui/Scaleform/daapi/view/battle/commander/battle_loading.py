from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading as BaseBattleLoading

class BattleLoading(BaseBattleLoading):

    def _formatTipTitle(self, tipTitleText):
        return tipTitleText

    def _formatTipBody(self, tipBody):
        return tipBody

    def _makeVisualTipVO(self, arenaDP, tip=None):
        vo = {'tipIcon': self.gui.resourceManager.getImagePath(tip.icon) if tip is not None else None}
        return vo