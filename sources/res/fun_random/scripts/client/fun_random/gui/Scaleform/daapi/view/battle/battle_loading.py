from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading

class FepBattleLoading(BattleLoading):

    def _getSettingsID(self, loadingInfo):
        return self.settingsCore.options.getSetting(loadingInfo).getSettingID(isVisualOnly=True)