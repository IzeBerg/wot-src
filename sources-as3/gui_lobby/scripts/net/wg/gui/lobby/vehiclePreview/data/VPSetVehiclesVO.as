package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class VPSetVehiclesVO extends DAAPIDataClass
   {
      
      private static const VEHICLES_DATA_FIELD_NAME:String = "vehicles";
       
      
      public var vehicles:DataProvider;
      
      public function VPSetVehiclesVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == VEHICLES_DATA_FIELD_NAME)
         {
            this.vehicles = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.vehicles.push(new VPVehicleCarouselVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VPVehicleCarouselVO = null;
         if(this.vehicles)
         {
            for each(_loc1_ in this.vehicles)
            {
               _loc1_.dispose();
            }
            this.vehicles.cleanUp();
            this.vehicles = null;
         }
         super.onDispose();
      }
   }
}
