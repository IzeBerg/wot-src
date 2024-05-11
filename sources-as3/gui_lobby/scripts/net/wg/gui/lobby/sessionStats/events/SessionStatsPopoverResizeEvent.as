package net.wg.gui.lobby.sessionStats.events
{
   import flash.events.Event;
   
   public class SessionStatsPopoverResizeEvent extends Event
   {
      
      public static const EXPANDED:String = "SessionStatsPopoverResizeEvent.EXPANDED";
      
      public static const RESIZED:String = "SessionStatsPopoverResizeEvent.RESIZED";
       
      
      private var _isExpanded:Boolean;
      
      public function SessionStatsPopoverResizeEvent(param1:String, param2:Boolean = false)
      {
         super(param1,true);
         this._isExpanded = param2;
      }
      
      public function get isExpanded() : Boolean
      {
         return this._isExpanded;
      }
      
      override public function clone() : Event
      {
         return new SessionStatsPopoverResizeEvent(type,this._isExpanded);
      }
   }
}
