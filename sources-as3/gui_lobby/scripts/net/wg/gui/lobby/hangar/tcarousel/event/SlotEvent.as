package net.wg.gui.lobby.hangar.tcarousel.event
{
   import flash.events.Event;
   
   public class SlotEvent extends Event
   {
      
      public static const TYPE_DEACTIVATED:String = "SloDeactivationEvent";
      
      public static const TYPE_SHIFT:String = "SlotShiftEvent";
      
      public static const TYPE_SELECT:String = "SlotSelectEvent";
       
      
      private var _vehicleId:int;
      
      public function SlotEvent(param1:String, param2:int)
      {
         super(param1,true);
         this._vehicleId = param2;
      }
      
      override public function clone() : Event
      {
         return new SlotEvent(type,this._vehicleId);
      }
      
      public function get vehicleId() : int
      {
         return this._vehicleId;
      }
   }
}
