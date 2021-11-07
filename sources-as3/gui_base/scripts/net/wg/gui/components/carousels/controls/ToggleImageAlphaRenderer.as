package net.wg.gui.components.carousels.controls
{
   import net.wg.gui.components.controls.ToggleRenderer;
   
   public class ToggleImageAlphaRenderer extends ToggleRenderer
   {
      
      private static const DESABLED_ALPHA:Number = 0.5;
       
      
      public function ToggleImageAlphaRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         btn.disabledImageAlpha = DESABLED_ALPHA;
      }
   }
}
