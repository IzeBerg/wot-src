package net.wg.gui.battle.components.stats.playersPanel.events
{
   import flash.events.Event;
   
   public class ChatCommandItemEvent extends Event
   {
      
      public static const ACTIVE_COMMAND_CHANGED:String = "activeCommandChanged";
       
      
      public var isActiveCommandVisible:Boolean = false;
      
      public function ChatCommandItemEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ChatCommandItemEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ChatCommandItemEvent","type","bubbles","cancelable");
      }
   }
}
