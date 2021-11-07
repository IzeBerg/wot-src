package net.wg.gui.components.questProgress.events
{
   import flash.events.Event;
   
   public class QuestProgressComponentEvent extends Event
   {
      
      public static const SHOW:String = "qpcShow";
      
      public static const HIDE:String = "qpcHide";
      
      public static const LAYOUT_COMPLETED:String = "layoutCompleted";
       
      
      public function QuestProgressComponentEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new QuestProgressComponentEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("QuestProgressComponentEvent","type","bubbles","cancelable");
      }
   }
}
