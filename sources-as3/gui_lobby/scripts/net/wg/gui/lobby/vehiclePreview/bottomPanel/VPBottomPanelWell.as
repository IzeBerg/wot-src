package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IVehiclePreviewBottomPanelWellMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBottomPanelWellMeta;
   
   public class VPBottomPanelWell extends VehiclePreviewBottomPanelWellMeta implements IVehiclePreviewBottomPanelWellMeta, IVPBottomPanel
   {
      
      private static const OFFSET:int = 1;
      
      private static const OFFSET_Y:int = 25;
      
      private static const WIDTH:uint = 1024 + 2 * OFFSET;
      
      private static const HEIGHT:uint = 210 + 2 * OFFSET;
       
      
      public function VPBottomPanelWell()
      {
         super();
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
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
   }
}
