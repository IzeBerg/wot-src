package net.wg.gui.lobby.vehPostProgression.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.VehicleButtonVO;
   
   public class VehPostProgressionViewVO extends DAAPIDataClass
   {
      
      private static const VEHICLE_BUTTON:String = "vehicleButton";
      
      private static const VEHICLE_INFO:String = "vehicleInfo";
       
      
      public var backBtnLabel:String = "";
      
      public var backBtnDescrLabel:String = "";
      
      public var demountAllButtonLabel:String = "";
      
      public var nation:String = "";
      
      public var showDemountAllPairsBtn:Boolean = false;
      
      public var showExpBlock:Boolean = false;
      
      private var _vehicleButton:VehicleButtonVO = null;
      
      private var _vehicleInfo:VehicleInfoVO = null;
      
      public function VehPostProgressionViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VEHICLE_BUTTON)
         {
            this._vehicleButton = new VehicleButtonVO(param2);
            return false;
         }
         if(param1 == VEHICLE_INFO)
         {
            this._vehicleInfo = new VehicleInfoVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._vehicleButton)
         {
            this._vehicleButton.dispose();
            this._vehicleButton = null;
         }
         if(this._vehicleInfo)
         {
            this._vehicleInfo.dispose();
            this._vehicleInfo = null;
         }
         super.onDispose();
      }
      
      public function get vehicleButton() : VehicleButtonVO
      {
         return this._vehicleButton;
      }
      
      public function get vehicleInfo() : VehicleInfoVO
      {
         return this._vehicleInfo;
      }
   }
}
