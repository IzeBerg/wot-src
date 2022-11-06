package net.wg.gui.components.crosshairPanel.VO
{
   public class CrosshairSettingsVO
   {
       
      
      public var centerAlphaValue:Number = -1;
      
      public var centerType:Number = -1;
      
      public var netAlphaValue:Number = -1;
      
      public var netType:Number = -1;
      
      public var reloaderAlphaValue:Number = -1;
      
      public var conditionAlphaValue:Number = -1;
      
      public var cassetteAlphaValue:Number = -1;
      
      public var reloaderTimerAlphaValue:Number = -1;
      
      public var zoomIndicatorAlphaValue:Number = -1;
      
      public var gunTagType:Number = 1;
      
      public var gunTagAlpha:Number = 1;
      
      public var mixingType:Number = 1;
      
      public var mixingAlpha:Number = 1;
      
      public var isColorBlind:Boolean = false;
      
      public var spgScaleWidgetEnabled:Boolean = false;
      
      public function CrosshairSettingsVO(param1:Object)
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         super();
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = _loc2_;
            if(hasOwnProperty(_loc4_))
            {
               if(!isNaN(_loc3_))
               {
                  this[_loc2_] = _loc3_;
               }
            }
         }
      }
   }
}
