package net.wg.gui.battle.views.messages.events
{
   import flash.events.Event;
   import net.wg.gui.battle.views.messages.IMessage;
   
   public class MessageEvent extends Event
   {
       
      
      public var message:IMessage;
      
      public function MessageEvent(param1:String, param2:IMessage, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.message = param2;
      }
   }
}
