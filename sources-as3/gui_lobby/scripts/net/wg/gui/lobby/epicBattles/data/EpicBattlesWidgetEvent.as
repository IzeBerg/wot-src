package net.wg.gui.lobby.epicBattles.data
{
   import flash.events.Event;
   
   public class EpicBattlesWidgetEvent extends Event
   {
      
      public static const LAYOUT_CHANGE:String = "epicWidgetLayoutChange";
       
      
      public function EpicBattlesWidgetEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EpicBattlesWidgetEvent(type,bubbles,cancelable);
      }
   }
}
