package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class FirstEntryCardEvent extends Event
   {
      
      public static const CARD_CLICK:String = "FirstEntryCardClick";
      
      public static const CLOSE_DESCRIPTION:String = "FirstEntryCardClick";
      
      public static const TO_NEXT:String = "onNextCardSelect";
      
      public static const TO_PREV:String = "onPreviousCardSelect";
       
      
      public var slotIndex:int = -1;
      
      public function FirstEntryCardEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.slotIndex = param2;
      }
      
      override public function clone() : Event
      {
         return new FirstEntryCardEvent(type,this.slotIndex,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "[FirstEntryCardEvent slotID:" + this.slotIndex + "]";
      }
   }
}
