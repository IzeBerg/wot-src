package net.wg.gui.lobby.vehicleCompare.configurator
{
   import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
   import net.wg.gui.lobby.hangar.VehicleParametersWithHighlight;
   
   public class VehConfParameters extends VehicleParametersWithHighlight
   {
      
      private static const BOTTOM_SHADOW_OFFSET:int = 8;
      
      private static const TOP_SHADOW_OFFSET:int = 11;
       
      
      public function VehConfParameters()
      {
         super();
      }
      
      override protected function getRendererLinkage() : String
      {
         return VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_PARAM_RENDERER_LINKAGE;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         snapHeightToRenderers = false;
         showShadowLipWhenOverflow = true;
         bg.visible = false;
      }
      
      override protected function updateLipsPosition() : void
      {
         topShadow.y = TOP_SHADOW_OFFSET;
         bottomShadow.y = height + BOTTOM_SHADOW_OFFSET;
      }
   }
}
