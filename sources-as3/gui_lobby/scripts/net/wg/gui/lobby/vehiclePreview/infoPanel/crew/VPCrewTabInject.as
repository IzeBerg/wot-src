package net.wg.gui.lobby.vehiclePreview.infoPanel.crew
{
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewCrewTabInjectMeta;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   
   public class VPCrewTabInject extends VehiclePreviewCrewTabInjectMeta implements IViewStackExContent
   {
      
      private static const TAB_SHIFT:int = -10;
       
      
      public function VPCrewTabInject()
      {
         super();
         setManageSize(false);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.y = TAB_SHIFT;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return undefined;
      }
      
      public function setActive(param1:Boolean) : void
      {
      }
      
      public function update(param1:Object) : void
      {
      }
   }
}
