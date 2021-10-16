package net.wg.gui.battle.views.questProgress.events
{
   import flash.events.Event;
   
   public class QuestProgressAnimatedWrapperEvent extends Event
   {
      
      public static const ALL_ANIM_COMPLETED:String = "allAnimCompleted";
       
      
      public function QuestProgressAnimatedWrapperEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new QuestProgressAnimatedWrapperEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("QuestProgressAnimatedWrapperEvent","type","bubbles","cancelable");
      }
   }
}
