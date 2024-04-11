package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class ExternalCursorEvent extends Event
   {
      
      public static const EXTERNAL_CURSOR_CHANGED:String = "externalCursorChanged";
       
      
      private var _cursor:String;
      
      public function ExternalCursorEvent(param1:String)
      {
         super(EXTERNAL_CURSOR_CHANGED,false,false);
         this._cursor = param1;
      }
      
      override public function toString() : String
      {
         return formatToString("externalCursorChanged","bubbles","cancelable","eventPhase");
      }
      
      public function get cursor() : String
      {
         return this._cursor;
      }
   }
}
