package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IVehiclePreviewProgressionStylesBuyingPanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewProgressionStylesBuyingPanelMeta;
   
   public class VPProgressionStylesBuyingPanel extends VehiclePreviewProgressionStylesBuyingPanelMeta implements IVehiclePreviewProgressionStylesBuyingPanelMeta, IVPBottomPanel
   {
      
      private static const OFFSET:int = 1;
      
      private static const OFFSET_Y:int = 25;
      
      private static const WIDTH:uint = 750 + 2 * OFFSET;
      
      private static const HEIGHT:uint = 210 + 2 * OFFSET;
       
      
      public function VPProgressionStylesBuyingPanel()
      {
         super();
      }
      
      public function getBtn() : SoundButtonEx
      {
         return undefined;
      }
      
      public function getTotalHeight() : Number
      {
         return HEIGHT;
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1 + OFFSET_Y;
      }
   }
}
