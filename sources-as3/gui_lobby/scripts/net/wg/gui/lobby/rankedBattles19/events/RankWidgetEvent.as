package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class RankWidgetEvent extends Event
   {
      
      public static const READY:String = "ready";
       
      
      public function RankWidgetEvent(param1:String, param2:Boolean = false)
      {
         super(param1,param2);
      }
      
      override public function clone() : Event
      {
         return new RankWidgetEvent(type,bubbles);
      }
      
      override public function toString() : String
      {
         return formatToString("RankWidgetEvent","type","bubbles");
      }
   }
}
