package net.wg.gui.lobby.sessionStats.events
{
   import flash.events.Event;
   
   public class SessionStatsSettingsInputEvent extends Event
   {
      
      public static const CHANGED:String = "SessionStatsSettingsInputEvent.CHANGED";
       
      
      private var _id:String;
      
      private var _value:int;
      
      public function SessionStatsSettingsInputEvent(param1:String, param2:int)
      {
         super(CHANGED,true);
         this._id = param1;
         this._value = param2;
      }
      
      override public function clone() : Event
      {
         return new SessionStatsSettingsInputEvent(this._id,this._value);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get value() : int
      {
         return this._value;
      }
   }
}
