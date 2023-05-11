package net.wg.gui.lobby.sessionStats.events
{
   import flash.events.Event;
   
   public class SessionStatsPopoverResizeEvent extends Event
   {
      
      public static const EXPANDED:String = "SessionStatsPopoverResizeEvent.EXPANDED";
      
      public static const EXTRA_SIZED:String = "SessionStatsPopoverResizeEvent.EXTRA_SIZED";
       
      
      private var _data:Object;
      
      public function SessionStatsPopoverResizeEvent(param1:String, param2:Object)
      {
         super(param1,true);
         this._data = param2;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new SessionStatsPopoverResizeEvent(type,this._data);
      }
   }
}
