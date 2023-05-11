package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.vehiclePreview.additionalInfo.VehicleInfoDescVO;
   
   public class VPAdditionalInfoVO extends DAAPIDataClass
   {
      
      private static const FIELD_VEHICLE_INFO_DESC:String = "vehicleInfoDesc";
       
      
      public var objectSubtitle:String = "";
      
      public var objectTitle:String = "";
      
      public var descriptionTitle:String = "";
      
      public var descriptionText:String = "";
      
      public var vehicleInfoDesc:VehicleInfoDescVO = null;
      
      public function VPAdditionalInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_VEHICLE_INFO_DESC)
         {
            this.vehicleInfoDesc = new VehicleInfoDescVO(param2);
            return false;
         }
         return this.hasOwnProperty(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.vehicleInfoDesc)
         {
            this.vehicleInfoDesc.dispose();
            this.vehicleInfoDesc = null;
         }
         super.onDispose();
      }
   }
}
