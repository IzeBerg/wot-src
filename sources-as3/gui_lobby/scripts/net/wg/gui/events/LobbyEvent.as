package net.wg.gui.events
{
   import flash.events.Event;
   
   public class LobbyEvent extends Event
   {
      
      public static const REGISTER_DRAGGING:String = "registerDragging";
      
      public static const UNREGISTER_DRAGGING:String = "unregisterDragging";
      
      public static const DRAGGING_START:String = "draggingStart";
      
      public static const DRAGGING_END:String = "draggingEnd";
      
      public static const DRAGGING:String = "dragging";
       
      
      public function LobbyEvent(param1:String)
      {
         super(param1,true,true);
      }
      
      override public function clone() : Event
      {
         return new LobbyEvent(type);
      }
   }
}
