package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class RewardYearEvent extends Event
   {
      
      public static const MAIN_AWARD_SHOW:String = "onMainAwardShow";
       
      
      public var isShow:Boolean = false;
      
      public function RewardYearEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.isShow = param2;
      }
      
      override public function clone() : Event
      {
         return new RewardYearEvent(type,this.isShow,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("RewardYearEvent","type","isShow","bubbles","cancelable");
      }
   }
}
