package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   import flash.filters.BlurFilter;
   
   public class BlurPlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:BlurPlugin;
      
      protected static var tweenProperties:Array = ["blurX","blurY","blur"];
       
      
      public function BlurPlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(instance)
         {
            return;
         }
         instance = new BlurPlugin();
         GTween.installPlugin(instance,tweenProperties);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         var _loc6_:BlurFilter = null;
         if(!(param1.pluginData.BlurEnabled == null && enabled || param1.pluginData.BlurEnabled))
         {
            return param3;
         }
         var _loc4_:Array = param1.target.filters;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_] is BlurFilter)
            {
               _loc6_ = _loc4_[_loc5_];
               param1.pluginData.BlurData = {"index":_loc5_};
               if(param2 == "blur")
               {
                  return (_loc6_.blurX + _loc6_.blurY) / 2;
               }
               return _loc6_[param2];
            }
            _loc5_++;
         }
         return 0;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(!(param1.pluginData.BlurEnabled == null && enabled || param1.pluginData.BlurEnabled))
         {
            return param3;
         }
         var _loc8_:Object = param1.pluginData.BlurData;
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
         if(param2 == "blur")
         {
            _loc10_.blurX = _loc10_.blurY = param3;
         }
         else
         {
            _loc10_[param2] = param3;
         }
         param1.target.filters = _loc9_;
         if(param7)
         {
            delete param1.pluginData.BlurData;
         }
         return NaN;
      }
      
      protected function initTarget(param1:GTween) : Object
      {
         var _loc2_:Array = param1.target.filters;
         _loc2_.push(new BlurFilter(0,0,1));
         param1.target.filters = _loc2_;
         return param1.pluginData.BlurData = {"index":_loc2_.length - 1};
      }
   }
}
