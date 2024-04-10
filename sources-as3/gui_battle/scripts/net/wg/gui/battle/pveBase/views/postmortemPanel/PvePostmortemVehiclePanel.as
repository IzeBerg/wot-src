package net.wg.gui.battle.pveBase.views.postmortemPanel
{
   import net.wg.gui.battle.views.postmortemPanel.VehiclePanel;
   
   public class PvePostmortemVehiclePanel extends VehiclePanel
   {
      
      private static const TYPE_OFFSET:int = 3;
       
      
      public function PvePostmortemVehiclePanel()
      {
         super();
         setChildIndex(typeMC,numChildren - 1);
      }
      
      override protected function adjustPositions() : void
      {
         super.adjustPositions();
         typeMC.x += TYPE_OFFSET;
         vehicleMC.y = bgMC.height - VEHICLE_IMAGE_HEIGHT >> 1;
      }
   }
}
