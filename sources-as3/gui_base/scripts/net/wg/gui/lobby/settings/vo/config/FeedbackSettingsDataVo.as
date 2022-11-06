package net.wg.gui.lobby.settings.vo.config
{
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.gui.lobby.settings.vo.config.feedback.BattleBorderMapDataVo;
   import net.wg.gui.lobby.settings.vo.config.feedback.BattleEventInfoDataVo;
   import net.wg.gui.lobby.settings.vo.config.feedback.DamageIndicatorDataVo;
   import net.wg.gui.lobby.settings.vo.config.feedback.DamageLogPanelDataVo;
   import net.wg.gui.lobby.settings.vo.config.feedback.QuestsProgressDataVo;
   
   public class FeedbackSettingsDataVo extends SettingsDataVo
   {
       
      
      public var feedbackDamageIndicator:DamageIndicatorDataVo = null;
      
      public var feedbackDamageLog:DamageLogPanelDataVo = null;
      
      public var feedbackBattleEvents:BattleEventInfoDataVo = null;
      
      public var feedbackBattleBorderMap:BattleBorderMapDataVo = null;
      
      public var feedbackQuestsProgress:QuestsProgressDataVo = null;
      
      public function FeedbackSettingsDataVo()
      {
         super({
            "feedbackDamageIndicator":new DamageIndicatorDataVo(),
            "feedbackDamageLog":new DamageLogPanelDataVo(),
            "feedbackBattleEvents":new BattleEventInfoDataVo(),
            "feedbackBattleBorderMap":new BattleBorderMapDataVo(),
            "feedbackQuestsProgress":new QuestsProgressDataVo()
         });
      }
      
      override protected function onDispose() : void
      {
         this.feedbackDamageIndicator = null;
         this.feedbackDamageLog = null;
         this.feedbackBattleEvents = null;
         this.feedbackBattleBorderMap = null;
         this.feedbackQuestsProgress = null;
         super.onDispose();
      }
   }
}
