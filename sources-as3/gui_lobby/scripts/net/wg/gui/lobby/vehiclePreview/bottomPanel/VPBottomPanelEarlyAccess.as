package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.meta.IVehiclePreviewBottomPanelEarlyAccessMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBottomPanelEarlyAccessMeta;
   
   public class VPBottomPanelEarlyAccess extends VehiclePreviewBottomPanelEarlyAccessMeta implements IVehiclePreviewBottomPanelEarlyAccessMeta, IVPBottomPanel
   {
       
      
      public function VPBottomPanelEarlyAccess()
      {
         super();
         setManageSize(false);
      }
      
      public function getBtn() : SoundButtonEx
      {
         return undefined;
      }
      
      public function getOffsetY() : int
      {
         return 0;
      }
      
      public function getSmallScreenOffsetY() : int
      {
         return 0;
      }
      
      public function getTotalHeight() : Number
      {
         return height;
      }
   }
}
