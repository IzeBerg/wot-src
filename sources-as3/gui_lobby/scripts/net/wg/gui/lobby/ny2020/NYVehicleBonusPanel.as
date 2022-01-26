package net.wg.gui.lobby.ny2020
{
   import fl.motion.AdjustColor;
   import fl.motion.easing.Quartic;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class NYVehicleBonusPanel extends UIComponentEx
   {
      
      private static const HIT_AREA_HEIGHT_OFFSET:int = 17;
      
      private static const FADE_TWEEN_DURATION:int = 300;
      
      private static const FADE_IN_ALPHA:int = 0;
      
      private static const FADE_OUT_ALPHA:int = 30;
       
      
      public var bg:MovieClip = null;
      
      public var hitAreaMc:MovieClip = null;
      
      private var _tooltip:String;
      
      private var _fadeTween:Tween = null;
      
      private var _brightness:Number = 0;
      
      public function NYVehicleBonusPanel()
      {
         super();
         hitArea = this.hitAreaMc;
         this.bg.mouseEnabled = false;
         buttonMode = true;
         stop();
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         removeEventListener(MouseEvent.MOUSE_OVER,this.showVehicleTooltip);
         removeEventListener(MouseEvent.MOUSE_OUT,this.hideBonusTooltip);
         this.hitAreaMc = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      public function setTooltip(param1:String) : void
      {
         this._tooltip = param1;
         invalidateData();
      }
      
      public function showOut() : void
      {
         this.playFadeTween(false);
         App.toolTipMgr.hide();
      }
      
      public function showOver() : void
      {
         this.playFadeTween(true);
         this.showVehicleTooltip();
      }
      
      private function onFade() : void
      {
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.brightness = this._brightness;
         _loc1_.saturation = 0;
         _loc1_.contrast = 0;
         _loc1_.hue = 0;
         filters = [new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray())];
      }
      
      private function clearTween() : void
      {
         if(this._fadeTween)
         {
            this._fadeTween.dispose();
            this._fadeTween = null;
         }
      }
      
      private function playFadeTween(param1:Boolean) : void
      {
         this.clearTween();
         this._fadeTween = new Tween(FADE_TWEEN_DURATION,this,{"brightness":(!!param1 ? FADE_OUT_ALPHA : FADE_IN_ALPHA)},{
            "paused":false,
            "ease":Quartic.easeOut,
            "onChange":this.onFade
         });
      }
      
      override public function get height() : Number
      {
         return this.hitAreaMc.height + HIT_AREA_HEIGHT_OFFSET;
      }
      
      public function get brightness() : Number
      {
         return this._brightness;
      }
      
      public function set brightness(param1:Number) : void
      {
         if(this._brightness != param1)
         {
            this._brightness = param1;
            invalidateState();
         }
      }
      
      public function showVehicleTooltip(param1:MouseEvent = null) : void
      {
         if(StringUtils.isNotEmpty(this._tooltip))
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }
      
      public function hideBonusTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         this.showOver();
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this.showOut();
      }
   }
}
