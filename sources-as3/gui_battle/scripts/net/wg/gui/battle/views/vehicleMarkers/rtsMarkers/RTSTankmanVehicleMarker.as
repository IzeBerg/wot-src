package net.wg.gui.battle.views.vehicleMarkers.rtsMarkers
{
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
   
   public class RTSTankmanVehicleMarker extends VehicleMarker
   {
       
      
      public function RTSTankmanVehicleMarker()
      {
         super();
      }
      
      override protected function getIsPartVisible(param1:String) : Boolean
      {
         var _loc2_:Boolean = super.getIsPartVisible(param1);
         if(param1 == P_NAME_LBL)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
   }
}
