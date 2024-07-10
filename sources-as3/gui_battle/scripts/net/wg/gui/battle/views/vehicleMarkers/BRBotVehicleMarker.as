package net.wg.gui.battle.views.vehicleMarkers
{
   public class BRBotVehicleMarker extends VehicleMarker
   {
      
      private static const VM_STUN_PREFIX:String = "vm_stun_br_";
      
      private static const VM_BUFF_PREFIX:String = "vm_buff_br_";
       
      
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
      
      override protected function get vmDebuffPrefix() : String
      {
         return VM_STUN_PREFIX;
      }
      
      override protected function get vmBuffPrefix() : String
      {
         return VM_BUFF_PREFIX;
      }
   }
}
