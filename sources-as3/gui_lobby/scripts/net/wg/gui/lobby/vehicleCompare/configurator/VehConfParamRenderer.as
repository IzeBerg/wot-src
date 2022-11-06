package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.components.data.VehParamVO;
   import net.wg.gui.lobby.hangar.vehicleParameters.components.VehParamRenderer;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehConfParamRenderer extends VehParamRenderer
   {
       
      
      public var anim:MovieClip;
      
      private var _prevValue:String;
      
      private var _prevTitle:String;
      
      private var _prevState:String;
      
      public function VehConfParamRenderer()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:VehParamVO = null;
         super.draw();
         if(data != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = VehParamVO(data);
            if(this._prevTitle == _loc1_.titleText && this._prevState == _loc1_.state && _loc1_.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP && _loc1_.valueText != this._prevValue)
            {
               this.anim.gotoAndPlay(2);
            }
            this.anim.visible = _loc1_.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP;
            this._prevValue = _loc1_.valueText;
            this._prevTitle = _loc1_.titleText;
            this._prevState = _loc1_.state;
         }
      }
   }
}
