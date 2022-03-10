package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IVehiclePreviewBottomPanelStyleBuyingMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBottomPanelStyleBuyingMeta;
   
   public class VPBottomPanelStyleBuying extends VehiclePreviewBottomPanelStyleBuyingMeta implements IVehiclePreviewBottomPanelStyleBuyingMeta, IVPBottomPanel
   {
      
      private static const OFFSET:int = 1;
      
      private static const OFFSET_Y:int = 60;
      
      private static const WIDTH:uint = 750 + 2 * OFFSET;
      
      private static const HEIGHT:uint = 210 + 2 * OFFSET;
       
      
      public function VPBottomPanelStyleBuying()
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
      
      override public function get y() : Number
      {
         return super.y - OFFSET_Y;
      }
   }
}
