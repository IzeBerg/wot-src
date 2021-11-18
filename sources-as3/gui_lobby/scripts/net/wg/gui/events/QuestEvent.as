package net.wg.gui.events
{
   import flash.events.Event;
   
   public class QuestEvent extends Event
   {
      
      public static const SELECT_QUEST:String = "selectQuest";
       
      
      public var questID:String = "";
      
      private var _eventType:int = -1;
      
      public function QuestEvent(param1:String, param2:String)
      {
         super(param1,true,true);
         this.questID = param2;
      }
      
      override public function clone() : Event
      {
         return new QuestEvent(type,this.questID);
      }
      
      public function get eventType() : int
      {
         return this._eventType;
      }
      
      public function set eventType(param1:int) : void
      {
         this._eventType = param1;
      }
   }
}
