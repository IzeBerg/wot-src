package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   import flash.filters.BlurFilter;
   
   public class MotionBlurPlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = false;
      
      public static var strength:Number = 0.6;
      
      protected static var instance:MotionBlurPlugin;
       
      
      public function MotionBlurPlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(instance)
         {
            return;
         }
         instance = new MotionBlurPlugin();
         GTween.installPlugin(instance,["x","y"]);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         return param3;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         var _loc11_:Number = NaN;
         if(!(enabled && param1.pluginData.MotionBlurEnabled == null || param1.pluginData.MotionBlurEnabled))
         {
            return param3;
         }
         var _loc8_:Object = param1.pluginData.MotionBlurData;
         if(_loc8_ == null)
         {
            _loc8_ = this.initTarget(param1);
         }
         var _loc9_:Array = param1.target.filters;
         var _loc10_:BlurFilter = _loc9_[_loc8_.index] as BlurFilter;
         if(_loc10_ == null)
         {
            return param3;
         }
         if(param7)
         {
            _loc9_.splice(_loc8_.index,1);
            delete param1.pluginData.MotionBlurData;
         }
         else
         {
            _loc11_ = Math.abs((param1.ratioOld - param6) * param5 * strength);
            if(param2 == "x")
            {
               _loc10_.blurX = _loc11_;
            }
            else
            {
               _loc10_.blurY = _loc11_;
            }
         }
         param1.target.filters = _loc9_;
         return param3;
      }
      
      protected function initTarget(param1:GTween) : Object
      {
         var _loc2_:Array = param1.target.filters;
         _loc2_.push(new BlurFilter(0,0,1));
         param1.target.filters = _loc2_;
         return param1.pluginData.MotionBlurData = {"index":_loc2_.length - 1};
      }
   }
}
