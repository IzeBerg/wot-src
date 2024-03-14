package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   import flash.geom.ColorTransform;
   
   public class ColorTransformPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var installed:Boolean = false;
      
      protected static var tweenProperties:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset","tint"];
       
      
      public function ColorTransformPlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(installed)
         {
            return;
         }
         installed = true;
         GTween.installPlugin(ColorTransformPlugin,tweenProperties,true);
      }
      
      public static function init(param1:GTween, param2:String, param3:Number) : Number
      {
         var _loc4_:ColorTransform = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         if(!(enabled && param1.pluginData.ColorTransformEnabled == null || param1.pluginData.ColorTransformEnabled))
         {
            return param3;
         }
         if(param2 == "tint")
         {
            _loc4_ = param1.target.transform.colorTransform;
            _loc5_ = Math.min(1,1 - _loc4_.redMultiplier);
            _loc6_ = Math.min(255,_loc4_.redOffset * _loc5_);
            _loc7_ = Math.min(255,_loc4_.greenOffset * _loc5_);
            _loc8_ = Math.min(255,_loc4_.blueOffset * _loc5_);
            return uint(_loc5_ * 255 << 24 | _loc6_ << 16 | _loc7_ << 8 | _loc8_);
         }
         return param1.target.transform.colorTransform[param2];
      }
      
      public static function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:Number = NaN;
         if(!(param1.pluginData.ColorTransformEnabled == null && enabled || param1.pluginData.ColorTransformEnabled))
         {
            return param3;
         }
         var _loc8_:ColorTransform = param1.target.transform.colorTransform;
         if(param2 == "tint")
         {
            _loc9_ = param4 >> 24 & 255;
            _loc10_ = param4 >> 16 & 255;
            _loc11_ = param4 >> 8 & 255;
            _loc12_ = param4 & 255;
            _loc13_ = param4 + param5 >> 0;
            _loc14_ = _loc9_ + param6 * ((_loc13_ >> 24 & 255) - _loc9_);
            _loc15_ = _loc10_ + param6 * ((_loc13_ >> 16 & 255) - _loc10_);
            _loc16_ = _loc11_ + param6 * ((_loc13_ >> 8 & 255) - _loc11_);
            _loc17_ = _loc12_ + param6 * ((_loc13_ & 255) - _loc12_);
            _loc18_ = 1 - _loc14_ / 255;
            param1.target.transform.colorTransform = new ColorTransform(_loc18_,_loc18_,_loc18_,_loc8_.alphaMultiplier,_loc15_,_loc16_,_loc17_,_loc8_.alphaOffset);
         }
         else
         {
            _loc8_[param2] = param3;
            param1.target.transform.colorTransform = _loc8_;
         }
         return NaN;
      }
   }
}
