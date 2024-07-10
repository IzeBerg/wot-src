package net.wg.gui.battle.views.vehicleMarkers
{
   public class BRVehicleMarker extends VehicleMarker
   {
      
      private static const VM_DEBUFF_PREFIX:String = "vm_stun_br_";
      
      private static const VM_BUFF_PREFIX:String = "vm_buff_br_";
       
      
      public function BRVehicleMarker()
      {
         super();
      }
      
      override protected function get vmDebuffPrefix() : String
      {
         return VM_DEBUFF_PREFIX;
      }
      
      override protected function get vmBuffPrefix() : String
      {
         return VM_BUFF_PREFIX;
      }
   }
}
