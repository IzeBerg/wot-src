package net.wg.gui.lobby.vehicleCompare.events
{
   import flash.events.Event;
   
   public class VehicleCompareCartEvent extends Event
   {
      
      public static const DELETE_ITEM:String = "VehicleCmpDeleteItemEvent";
       
      
      private var _id:Number;
      
      public function VehicleCompareCartEvent(param1:Number)
      {
         super(DELETE_ITEM,true,false);
         this._id = param1;
      }
      
      override public function clone() : Event
      {
         return new VehicleCompareCartEvent(this._id);
      }
      
      public function get id() : Number
      {
         return this._id;
      }
   }
}
