package net.wg.gui.lobby.personalMissions.events
{
   import flash.events.Event;
   
   public class TankgirlRendererEvent extends Event
   {
      
      public static const CLICK:String = "TankgirlRendererClick";
       
      
      private var _idx:String;
      
      public function TankgirlRendererEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._idx = param2;
      }
      
      override public function clone() : Event
      {
         return new TankgirlRendererEvent(type,this._idx,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return "[TankgirlRendererEvent " + this._idx + "]";
      }
      
      public function get idx() : String
      {
         return this._idx;
      }
   }
}
