package net.wg.gui.lobby.vehiclePreview.topPanel
{
   import net.wg.infrastructure.base.meta.IVehiclePreviewTopPanelTabsMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewTopPanelTabsMeta;
   
   public class VPTopPanelTabs extends VehiclePreviewTopPanelTabsMeta implements IVehiclePreviewTopPanelTabsMeta, IVPTopPanel
   {
      
      private static const OFFSET_Y:uint = 32;
      
      private static const WIDTH:uint = 416;
      
      private static const HEIGHT:uint = 120;
       
      
      public function VPTopPanelTabs()
      {
         super();
         super.y = OFFSET_Y;
         setManageSize(true);
         setSize(WIDTH,HEIGHT);
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1 + OFFSET_Y;
      }
      
      override public function get y() : Number
      {
         return super.y - OFFSET_Y;
      }
   }
}
