package net.wg.gui.battle.random.views.stats.events
{
   import flash.events.Event;
   
   public class DynamicSquadEvent extends Event
   {
      
      public static const ACCEPT:String = "accept";
      
      public static const ADD:String = "add";
       
      
      private var _sessionID:String = "";
      
      public function DynamicSquadEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._sessionID = param2;
      }
      
      public function get sessionID() : String
      {
         return this._sessionID;
      }
      
      override public function clone() : Event
      {
         return new DynamicSquadEvent(type,this._sessionID,bubbles,cancelable);
      }
   }
}
