package net.wg.gui.components.crosshairPanel
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class CrosshairSniper extends CrosshairWithCassette
   {
      
      private static const CASSETE_POSITION_DIAGONAL:Number = -2;
      
      private static const CASSETE_POSITION_HORIZONTAL:Number = 8;
      
      private static const CASSETE_POSITION_RADIAL:Number = -2;
      
      private static const CASSETE_POSITION_DASHED:Number = -2;
       
      
      public var zoomTF:TextField = null;
      
      protected var _zoomIndicatorAlphaValue:Number = 1;
      
      private var _zoomStr:String = "";
      
      public function CrosshairSniper()
      {
         super();
      }
      
      private static function createComponent(param1:String) : DisplayObject
      {
         var _loc2_:Class = Class(getDefinitionByName(param1));
         return new _loc2_();
      }
      
      override public function dispose() : void
      {
         this.zoomTF = null;
         super.dispose();
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
      
      override protected function getCassettePositions() : Array
      {
         return [CASSETE_POSITION_DIAGONAL,CASSETE_POSITION_HORIZONTAL,CASSETE_POSITION_RADIAL,CASSETE_POSITION_DASHED];
      }
   }
}
