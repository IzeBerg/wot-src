package net.wg.gui.lobby.hangar.vehicleParameters.components
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.infrastructure.uilogger.veh_post_progression.Constants;
   import net.wg.infrastructure.uilogger.veh_post_progression.LogVehParams;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehParamRendererWithHighlight extends VehParamRenderer
   {
       
      
      public var glow:MovieClip = null;
      
      private var _logger:LogVehParams;
      
      public function VehParamRendererWithHighlight()
      {
         this._logger = new LogVehParams();
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
         this._logger.showTooltip();
      }
      
      override protected function onHideTooltip() : void
      {
         super.onHideTooltip();
         this._logger.hideTooltip(Constants.GROUP_MODIFICATIONS_TREE);
      }
      
      override protected function onDispose() : void
      {
         this.glow = null;
         this._logger.dispose();
         this._logger = null;
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
