package net.wg.gui.battle.views.vehicleMarkers
{
   public class BRVehicleMarker extends VehicleMarker
   {
      
      private static const VM_STUN_PREFIX:String = "vm_stun_br_";
       
      
      public function BRVehicleMarker()
      {
         super();
      }
      
      override protected function get vmStunPrefix() : String
      {
         return VM_STUN_PREFIX;
      }
   }
}
