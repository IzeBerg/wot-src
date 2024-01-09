package net.wg.gui.battle.views.vehicleMarkers
{
   public class BRBotVehicleMarker extends VehicleMarker
   {
       
      
      public function BRBotVehicleMarker()
      {
         super();
      }
      
      override protected function getIsPartVisible(param1:String) : Boolean
      {
         if(param1 == P_NAME_LBL || param1 == LEVEL || param1 == ICON)
         {
            return false;
         }
         return super.getIsPartVisible(param1);
      }
   }
}
