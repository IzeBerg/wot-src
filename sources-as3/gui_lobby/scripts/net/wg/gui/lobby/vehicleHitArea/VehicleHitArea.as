package net.wg.gui.lobby.vehicleHitArea
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.IMagneticClickHandler;
   
   public class VehicleHitArea extends MovieClip implements IMagneticClickHandler
   {
       
      
      public function VehicleHitArea()
      {
         super();
      }
      
      public function handleLeftClick(param1:MouseEvent) : Boolean
      {
         return param1.target == this;
      }
   }
}
