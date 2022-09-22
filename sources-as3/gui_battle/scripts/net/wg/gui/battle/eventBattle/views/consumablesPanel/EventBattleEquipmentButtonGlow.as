package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButtonGlow;
   
   public class EventBattleEquipmentButtonGlow extends BattleEquipmentButtonGlow
   {
      
      private static const SHOW_GLOW_YELLOW_STATE:String = "yellow";
      
      private static const SHOW_GLOW_HIDE_STATE:String = "hide";
      
      private static const SHOW_GLOW_IDLE_STATE:String = "idle";
      
      private static const SHOW_GLOW_TIMEOUT_STATE:String = "timeout";
      
      private static const SHOW_GLOW_HIDETEXT_STATE:String = "hideText";
      
      private static const SHOW_GLOW_HIDEBACK_STATE:String = "hideBack";
      
      private static const READY_TEXT_COLOR:uint = 7977983;
      
      private static const EVENT_NORMAL_TEXT_COLOR:uint = 16777215;
       
      
      public function EventBattleEquipmentButtonGlow()
      {
         super();
      }
      
      public function glowYellow() : void
      {
         if(currentLabel != SHOW_GLOW_YELLOW_STATE && currentLabel != SHOW_GLOW_TIMEOUT_STATE)
         {
            gotoAndPlay(SHOW_GLOW_YELLOW_STATE);
            bindKeyField.textColor = READY_TEXT_COLOR;
         }
      }
      
      public function hideText() : void
      {
         if(currentLabel == SHOW_GLOW_YELLOW_STATE)
         {
            gotoAndPlay(SHOW_GLOW_HIDETEXT_STATE);
            bindKeyField.textColor = this.normalTextColor;
         }
      }
      
      override public function glowOrange() : void
      {
         gotoAndPlay(SHOW_GLOW_ORANGE_STATE);
         bindKeyField.textColor = READY_TEXT_COLOR;
      }
      
      override public function hideGlow(param1:Boolean = true) : void
      {
         if(currentLabel == SHOW_GLOW_YELLOW_STATE)
         {
            gotoAndPlay(SHOW_GLOW_HIDE_STATE);
            bindKeyField.textColor = this.normalTextColor;
         }
         else if(currentLabel == SHOW_GLOW_HIDETEXT_STATE)
         {
            gotoAndPlay(SHOW_GLOW_HIDEBACK_STATE);
            bindKeyField.textColor = this.normalTextColor;
         }
         else if(currentLabel == SHOW_GLOW_TIMEOUT_STATE || currentLabel == SHOW_GLOW_ORANGE_STATE)
         {
            gotoAndStop(SHOW_GLOW_IDLE_STATE);
            bindKeyField.textColor = this.normalTextColor;
         }
      }
      
      public function hideOnTimeout() : void
      {
         if(currentLabel == SHOW_GLOW_YELLOW_STATE)
         {
            gotoAndPlay(SHOW_GLOW_TIMEOUT_STATE);
            bindKeyField.textColor = this.normalTextColor;
         }
      }
      
      override protected function get normalTextColor() : uint
      {
         return EVENT_NORMAL_TEXT_COLOR;
      }
   }
}
