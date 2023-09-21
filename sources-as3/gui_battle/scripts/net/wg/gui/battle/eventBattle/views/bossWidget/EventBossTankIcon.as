package net.wg.gui.battle.eventBattle.views.bossWidget
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventBossTankIcon extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_SHIELD_ONLINE:String = "shieldOnline";
      
      private static const FRAME_LABEL_SHIELD_OFFLINE:String = "shieldOffline";
      
      private static const FRAME_LABEL_SPECIAL_TANK:String = "specialTank";
       
      
      public function EventBossTankIcon()
      {
         super();
      }
      
      public function setShieldOnline() : void
      {
         if(currentFrameLabel == FRAME_LABEL_SPECIAL_TANK)
         {
            return;
         }
         if(currentFrameLabel != FRAME_LABEL_SHIELD_ONLINE)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_ONLINE);
         }
      }
      
      public function setShieldOffline() : void
      {
         if(currentFrameLabel == FRAME_LABEL_SPECIAL_TANK)
         {
            return;
         }
         if(currentFrameLabel != FRAME_LABEL_SHIELD_OFFLINE)
         {
            gotoAndStop(FRAME_LABEL_SHIELD_OFFLINE);
         }
      }
      
      public function setSpecialTank() : void
      {
         if(currentFrameLabel != FRAME_LABEL_SPECIAL_TANK)
         {
            gotoAndStop(FRAME_LABEL_SPECIAL_TANK);
         }
      }
   }
}
