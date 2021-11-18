package net.wg.gui.messenger.evnts
{
   import flash.events.Event;
   
   public class ChannelsFormEvent extends Event
   {
      
      public static var SEARCH_CHANNEL_CLICK:String = "on_search_channel_click";
      
      public static var JOIN:String = "on_join";
      
      public static var CREATE_CHANNEL:String = "on_create_channel";
       
      
      public var channelName:String = "";
      
      public var channelPass:String = null;
      
      public var channelRetypePass:String = null;
      
      public var index:Number = -1;
      
      public function ChannelsFormEvent(param1:String, param2:Boolean = true, param3:Boolean = false, param4:String = "", param5:String = null, param6:String = null, param7:Number = -1)
      {
         super(param1,param2,param3);
         this.channelName = param4;
         this.channelPass = param5;
         this.channelRetypePass = param6;
         this.index = param7;
      }
      
      override public function clone() : Event
      {
         return new ChannelsFormEvent(type,bubbles,cancelable,this.channelName,this.channelPass,this.channelRetypePass,this.index);
      }
      
      override public function toString() : String
      {
         return formatToString("ChannelsFormEvent","type","cancelable","eventPhase","channelName","channelPass","channelRetypePass","index");
      }
   }
}
