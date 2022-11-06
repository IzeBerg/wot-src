from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading
from account_helpers.settings_core.options import BattleLoadingTipSetting

class Comp7BattleLoading(BattleLoading):

    def _getViewSettingByID(self, settingID):
        result = super(Comp7BattleLoading, self)._getViewSettingByID(settingID)
        result.update({'leftTeamTitleLeft': -483, 
           'rightTeamTitleLeft': 275})
        return result

    def _makeVisualTipVO(self, arenaDP, tip=None):
        settingID = BattleLoadingTipSetting.OPTIONS.MINIMAP
        vo = {'settingID': settingID, 
           'tipIcon': None, 
           'arenaTypeID': self._arenaVisitor.type.getID(), 
           'minimapTeam': arenaDP.getNumberOfTeam(), 
           'showMinimap': True, 
           'showTipsBackground': True}
        vo.update(self._getViewSettingByID(settingID))
        return vo