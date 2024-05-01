package net.wg.gui.lobby.vehiclePreview
{
   import flash.events.Event;
   
   public class VehiclePreviewEvent extends Event
   {
      
      public static const SELECT:String = "VehiclePreviewEvent:select";
      
      public static const SHOW:String = "VehiclePreviewEvent:show";
      
      public static const SHOW_TOOLTIP:String = "VehiclePreviewEvent:showTooltip";
       
      
      private var _data:Object;
      
      public function VehiclePreviewEvent(param1:String, param2:Object)
      {
         super(param1,true,false);
         this._data = param2;
      }
      
      override public function clone() : Event
      {
         return new VehiclePreviewEvent(type,this.data);
      }
      
      override public function toString() : String
      {
         return formatToString("VehiclePreviewEvent","type","data");
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}
