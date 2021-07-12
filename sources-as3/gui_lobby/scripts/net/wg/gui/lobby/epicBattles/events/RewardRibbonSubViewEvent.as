package net.wg.gui.lobby.epicBattles.events
{
   import flash.events.Event;
   
   public class RewardRibbonSubViewEvent extends Event
   {
      
      public static const RIBBON_REWARD_BUTTON_CLICK:String = "ribbonRewardButtonClick";
       
      
      public function RewardRibbonSubViewEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EpicBattleInfoViewClickEvent(type,bubbles,cancelable);
      }
   }
}
