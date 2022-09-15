package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class RewardsEvent extends Event
   {
      
      public static const SHOW_STYLE:String = "show_style";
      
      public static const RENDERER_ANIMATION_COMPLETE:String = "rendererAnimationComplete";
       
      
      public var data:int = -1;
      
      public function RewardsEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new RewardsEvent(type,this.data,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("RewardsEvent","type","data","bubbles","cancelable");
      }
   }
}
