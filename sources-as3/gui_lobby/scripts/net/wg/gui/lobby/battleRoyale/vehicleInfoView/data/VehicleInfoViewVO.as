package net.wg.gui.lobby.battleRoyale.vehicleInfoView.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.battleRoyale.data.IVehicleWeakZonesVO;
   
   public class VehicleInfoViewVO extends DAAPIDataClass implements IVehicleWeakZonesVO
   {
       
      
      public var vehTitle:String = "";
      
      public var nationIcon:String = "";
      
      public var btnInfoLabel:String = "";
      
      public var btnCloseLabel:String = "";
      
      public var infoIconSource:String = "";
      
      public var weakZones:String = "";
      
      private var _engineLabel:String = "";
      
      private var _ammunitionLabel:String = "";
      
      public function VehicleInfoViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      public function get engineLabel() : String
      {
         return this._engineLabel;
      }
      
      public function set engineLabel(param1:String) : void
      {
         this._engineLabel = param1;
      }
      
      public function get ammunitionLabel() : String
      {
         return this._ammunitionLabel;
      }
      
      public function set ammunitionLabel(param1:String) : void
      {
         this._ammunitionLabel = param1;
      }
      
      public function get weakZonesSrc() : String
      {
         return this.weakZones;
      }
   }
}
