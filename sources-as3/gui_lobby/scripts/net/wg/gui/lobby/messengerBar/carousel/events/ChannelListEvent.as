package net.wg.gui.lobby.messengerBar.carousel.events
{
   import flash.events.Event;
   
   public class ChannelListEvent extends Event
   {
      
      public static const OPEN_CHANNEL:String = "openChannel";
      
      public static const CLOSE_CHANNEL:String = "closeChannel";
      
      public static const CLOSE_ALL:String = "closeAll";
       
      
      public var clientID:Number;
      
      public function ChannelListEvent(param1:String, param2:Number, param3:Boolean = false, param4:Boolean = true)
      {
         super(param1,param3,param4);
         this.clientID = param2;
      }
      
      override public function clone() : Event
      {
         return new ChannelListEvent(type,this.clientID,bubbles,cancelable);
      }
   }
}
