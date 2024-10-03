package net.wg.gui.components.crosshairPanel
{
   import flash.text.TextField;
   
   public class CrosshairSniper extends WTCrosshairBase
   {
      
      private static const RELOAD_TIME_BLINK_Y_DIAGONAL:int = 7;
      
      private static const RELOAD_TIME_BLINK_Y_HORIZONTAL:int = 39;
      
      private static const RELOAD_TIME_BLINK_Y_RADIAL:int = 11;
      
      private static const RELOAD_TIME_BLINK_Y_DASHED:int = 39;
      
      private static const RELOAD_TIME_BLINK_Y_SIEGE:int = 25;
      
      private static const PLASMA_INDICATOR_Y_HORIZONTAL:Number = 550;
      
      private static const PLASMA_INDICATOR_Y_DIAGONAL:Number = 1050;
      
      private static const PLASMA_INDICATOR_Y_RADIAL:Number = 550;
      
      private static const PLASMA_INDICATOR_Y_DASHED:Number = 550;
      
      private static const PLASMA_INDICATOR_Y_SIEGE:Number = 550;
       
      
      public var zoomTF:TextField = null;
      
      private var _zoomIndicatorAlphaValue:Number = 1;
      
      private var _zoomStr:String = "";
      
      public function CrosshairSniper()
      {
         super();
      }
      
      override public function setComponentsAlpha(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
      {
         this._zoomIndicatorAlphaValue = param7;
         super.setComponentsAlpha(param1,param2,param3,param4,param5,param6,param7);
         this.zoomTF.alpha = this._zoomIndicatorAlphaValue;
      }
      
      override public function setNetType(param1:Number) : void
      {
         super.setNetType(param1);
         this.zoomTF.text = this._zoomStr;
         this.zoomTF.alpha = this._zoomIndicatorAlphaValue;
      }
      
      override public function setZoom(param1:String) : void
      {
         if(this._zoomStr == param1)
         {
            return;
         }
         this._zoomStr = param1;
         this.zoomTF.text = this._zoomStr;
      }
      
      override protected function onDispose() : void
      {
         this.zoomTF = null;
         super.onDispose();
      }
      
      override protected function getReloadTimeBlinkYPos() : Array
      {
         return [RELOAD_TIME_BLINK_Y_DIAGONAL,RELOAD_TIME_BLINK_Y_HORIZONTAL,RELOAD_TIME_BLINK_Y_RADIAL,RELOAD_TIME_BLINK_Y_DASHED,RELOAD_TIME_BLINK_Y_SIEGE];
      }
      
      override protected function getPlasmaDamageIndicatorYPos() : Array
      {
         return [PLASMA_INDICATOR_Y_DIAGONAL,PLASMA_INDICATOR_Y_HORIZONTAL,PLASMA_INDICATOR_Y_RADIAL,PLASMA_INDICATOR_Y_DASHED,PLASMA_INDICATOR_Y_SIEGE];
      }
   }
}
