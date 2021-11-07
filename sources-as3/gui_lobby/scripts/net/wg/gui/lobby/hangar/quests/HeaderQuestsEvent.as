package net.wg.gui.lobby.hangar.quests
{
   import flash.events.Event;
   
   public class HeaderQuestsEvent extends Event
   {
      
      public static const HEADER_QUEST_CLICK:String = "onHeaderQuestClick";
      
      public static const HEADER_QUEST_OVER:String = "onHeaderQuestOver";
      
      public static const ANIM_START:String = "onHeaderQuestAnimStart";
       
      
      public var questType:String = "";
      
      public var questID:String = "";
      
      public var isEnable:Boolean = false;
      
      public var isSingle:Boolean = false;
      
      public function HeaderQuestsEvent(param1:String, param2:String, param3:String, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.questType = param2;
         this.questID = param3;
         this.isEnable = param4;
         this.isSingle = param5;
      }
      
      override public function clone() : Event
      {
         return new HeaderQuestsEvent(type,this.questType,this.questID,this.isEnable,this.isSingle,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("HeaderQuestsEvent","type","questType","questID","isEnable","isSingle","bubbles","cancelable");
      }
   }
}
