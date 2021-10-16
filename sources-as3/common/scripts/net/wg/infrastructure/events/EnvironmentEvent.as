package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class EnvironmentEvent extends Event
   {
      
      public static const LOGOFF:String = "WoTLogoff";
      
      public static const QIUT:String = "WoTQuit";
       
      
      private var _args:Array = null;
      
      public function EnvironmentEvent(param1:String, ... rest)
      {
         this._args = rest;
         super(param1);
      }
      
      public function getArgs() : Array
      {
         return this._args;
      }
   }
}
