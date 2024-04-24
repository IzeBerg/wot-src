package net.wg.gui.lobby.hangar.vehicleParameters.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehParamRendererWithHighlight extends VehParamRenderer
   {
       
      
      public var glow:MovieClip = null;
      
      public function VehParamRendererWithHighlight()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.glow)
         {
            this.glow.mouseEnabled = this.glow.mouseChildren = false;
         }
      }
      
      override protected function onShowTooltip() : void
      {
         super.onShowTooltip();
      }
      
      override protected function onHideTooltip() : void
      {
         super.onHideTooltip();
      }
      
      override protected function onDispose() : void
      {
         this.glow = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_model != null && isInvalid(InvalidationType.DATA))
         {
            if(this.glow)
            {
               this.glow.gotoAndStop(HANGAR_ALIASES.VEH_PARAM_RENDERER_HIGHLIGHT_NONE);
            }
         }
      }
      
      public function playHighlightAnimation() : void
      {
         if(_model && this.glow)
         {
            this.glow.gotoAndStop(_model.highlight);
         }
      }
   }
}
