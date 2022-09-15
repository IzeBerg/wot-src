package net.wg.gui.lobby.messengerBar.carousel.events
{
   import flash.events.Event;
   
   public class MessengerBarChannelCarouselEvent extends Event
   {
      
      public static const CHANNEL_WINDOW_FOCUS_IN:String = "ChannelWindowFocusIn";
      
      public static const CHANNEL_WINDOW_FOCUS_OUT:String = "ChannelWindowFocusOut";
      
      public static const CHANNEL_WINDOW_SHOW:String = "ChannelWindowShow";
      
      public static const CHANNEL_WINDOW_HIDE:String = "ChannelWindowHide";
       
      
      public var clientID:Number = 0;
      
      public var itemType:String = "";
      
      public function MessengerBarChannelCarouselEvent(param1:String, param2:Number, param3:String, param4:Boolean = true, param5:Boolean = false)
      {
         this.clientID = param2;
         this.itemType = param3;
         super(param1,param4,param5);
      }
      
      override public function clone() : Event
      {
         return new MessengerBarChannelCarouselEvent(type,this.clientID,this.itemType,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("MessengerBarChannelCarouselEvent","type","clientID","wndType","bubbles","cancelable");
      }
   }
}
