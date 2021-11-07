package net.wg.gui.battle.eventBattle.views.eventBuffNotificationSystem
{
   import flash.events.Event;
   
   public class ResizableBuffNotificationSystemEvent extends Event
   {
      
      public static const CHANGED_WIDTH_EVENT:String = "changedWidthEvent";
      
      public static const CHANGED_TOP_EVENT:String = "changedTopEvent";
       
      
      public function ResizableBuffNotificationSystemEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ResizableBuffNotificationSystemEvent(type,bubbles,cancelable);
      }
   }
}
