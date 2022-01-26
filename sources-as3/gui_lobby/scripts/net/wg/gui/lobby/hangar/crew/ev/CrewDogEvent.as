package net.wg.gui.lobby.hangar.crew.ev
{
   import flash.events.Event;
   
   public class CrewDogEvent extends Event
   {
      
      public static const TO_MORE_INFO_CLICK:String = "toMoreInfoClick";
      
      public static const ON_ITEM_CLICK:String = "onItemClick";
       
      
      public var contentWidth:Number;
      
      public function CrewDogEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new CrewDogEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CrewDogEvent","type","bubbles","cancelable");
      }
   }
}
