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
         setManageSize(true);
         setSize(WIDTH,HEIGHT);
      }
      
      public function getBtn() : SoundButtonEx
      {
         return undefined;
      }
      
      public function getOffsetY() : int
      {
         return OFFSET_Y;
      }
      
      public function getSmallScreenOffsetY() : int
      {
         return 0;
      }
      
      public function getTotalHeight() : Number
      {
         return HEIGHT;
      }
   }
}
