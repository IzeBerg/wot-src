package net.wg.infrastructure.events
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   
   public class DropEvent extends Event
   {
      
      public static const BEFORE_DROP:String = "onBeforeDrop";
      
      public static const AFTER_DROP:String = "onAfterDrop";
      
      public static const START_DROP:String = "onStartDrop";
      
      public static const END_DROP:String = "onEndDrop";
       
      
      private var _sender:InteractiveObject = null;
      
      private var _receiver:InteractiveObject = null;
      
      private var _draggedItem:InteractiveObject = null;
      
      public function DropEvent(param1:String, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject)
      {
         super(param1,bubbles,cancelable);
         this._sender = param2;
         this._receiver = param3;
         this._draggedItem = param4;
      }
      
      public function get draggedItem() : InteractiveObject
      {
         return this._draggedItem;
      }
      
      public function get sender() : InteractiveObject
      {
         return this._sender;
      }
      
      public function get receiver() : InteractiveObject
      {
         return this._receiver;
      }
   }
}
