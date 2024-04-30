package net.wg.gui.battle.historicalBattles.playersPanel.events
{
   import flash.events.Event;
   
   public class HBPlayerListEvent extends Event
   {
      
      public static const SIZE_CHANGE:String = "sizeChanged";
       
      
      public function HBPlayerListEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
