package net.wg.gui.events
{
   import flash.events.Event;
   
   public class MessengerBarEvent extends Event
   {
      
      public static const PIN_CAROUSEL_WINDOW:String = "pinCarouselWidow";
      
      public static const PIN_CHANNELS_WINDOW:String = "pinChannelsWidow";
       
      
      public var clientID:Number = 0;
      
      public function MessengerBarEvent(param1:String, param2:Number = 0, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.clientID = param2;
      }
      
      override public function clone() : Event
      {
         return new MessengerBarEvent(type,this.clientID,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("MessengerBarEvent","type","clientID","bubbles","cancelable");
      }
   }
}
