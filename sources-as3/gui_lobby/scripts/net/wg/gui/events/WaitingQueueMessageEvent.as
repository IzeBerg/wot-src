package net.wg.gui.events
{
   import flash.events.Event;
   
   public class WaitingQueueMessageEvent extends Event
   {
      
      public static const UPDATE_MESSAGE:String = "updateMessage";
       
      
      private var _message:String;
      
      public function WaitingQueueMessageEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._message = param2;
      }
      
      public function get message() : String
      {
         return this._message;
      }
   }
}
