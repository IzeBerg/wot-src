from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading, BattleLoadingTipSetting

class RankedBattleLoading(BattleLoading):

    def _getViewSettingByID(self, settingID):
        result = {}
        if settingID != BattleLoadingTipSetting.OPTIONS.TEXT:
            result.update({'leftTeamTitleLeft': -475, 
               'rightTeamTitleLeft': 270, 
               'tipTitleTop': 356, 
               'tipBodyTop': 387, 
               'showTableBackground': False, 
               'showTipsBackground': True})
        else:
            result = super(RankedBattleLoading, self)._getViewSettingByID(settingID)
        return result