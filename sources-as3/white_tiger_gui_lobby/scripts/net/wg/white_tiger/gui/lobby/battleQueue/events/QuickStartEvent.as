package net.wg.white_tiger.gui.lobby.battleQueue.events
{
   import flash.events.Event;
   
   public class QuickStartEvent extends Event
   {
      
      public static const VEHICLE_SELECTED:String = "vehicleSelected";
      
      public static const QUICK_START:String = "quickStart";
       
      
      private var _vehId:int = 0;
      
      public function QuickStartEvent(param1:String, param2:int, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._vehId = param2;
      }
      
      override public function clone() : Event
      {
         return new QuickStartEvent(type,this._vehId,bubbles,cancelable);
      }
      
      public function get vehId() : int
      {
         return this._vehId;
      }
   }
}
