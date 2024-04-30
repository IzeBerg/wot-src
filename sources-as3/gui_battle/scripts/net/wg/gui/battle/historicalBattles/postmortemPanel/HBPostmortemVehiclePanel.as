package net.wg.gui.battle.historicalBattles.postmortemPanel
{
   import net.wg.gui.battle.views.postmortemPanel.VehiclePanel;
   
   public class HBPostmortemVehiclePanel extends VehiclePanel
   {
       
      
      public function HBPostmortemVehiclePanel()
      {
         super();
         levelTF.visible = false;
      }
      
      override protected function adjustPositions() : void
      {
         vehicleMC.y = this.height - VEHICLE_IMAGE_HEIGHT >> 1;
         vehicleMC.x = HORIZONTAL_MARGIN;
         typeMC.x = vehicleMC.x + vehicleMC.width * vehicleMC.scaleX - ELEMENTS_GAP;
         nameTF.x = typeMC.x + typeMC.originalWidth + ELEMENTS_GAP;
         bgMC.width = nameTF.x + nameTF.width + HORIZONTAL_MARGIN;
         this.x = -this.width >> 1;
      }
   }
}
