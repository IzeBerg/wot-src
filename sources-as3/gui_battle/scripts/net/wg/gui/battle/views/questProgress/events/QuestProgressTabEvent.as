package net.wg.gui.battle.views.questProgress.events
{
   import flash.events.Event;
   
   public class QuestProgressTabEvent extends Event
   {
      
      public static const QUEST_SELECT:String = "questSelect";
       
      
      public var questID:uint = 0;
      
      public var fullMissionName:String = "";
      
      public function QuestProgressTabEvent(param1:String, param2:uint, param3:String, param4:Boolean = true, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.questID = param2;
         this.fullMissionName = param3;
      }
      
      override public function clone() : Event
      {
         return new QuestProgressTabEvent(type,this.questID,this.fullMissionName,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("QuestProgressTabEvent","type","questID","fullMissionName","bubbles","cancelable");
      }
   }
}
