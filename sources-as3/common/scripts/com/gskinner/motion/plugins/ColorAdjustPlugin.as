package com.gskinner.motion.plugins
{
   import com.gskinner.geom.ColorMatrix;
   import com.gskinner.motion.GTween;
   import flash.filters.ColorMatrixFilter;
   
   public class ColorAdjustPlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:ColorAdjustPlugin;
      
      protected static var tweenProperties:Array = ["brightness","contrast","hue","saturation"];
       
      
      public function ColorAdjustPlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(instance)
         {
            return;
         }
         instance = new ColorAdjustPlugin();
         GTween.installPlugin(instance,tweenProperties);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:ColorMatrixFilter = null;
         var _loc7_:Object = null;
         if(!(param1.pluginData.ColorAdjustEnabled == null && enabled || param1.pluginData.ColorAdjustEnabled))
         {
            return param3;
         }
         if(param1.pluginData.ColorAdjustData == null)
         {
            _loc4_ = param1.target.filters;
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(_loc4_[_loc5_] is ColorMatrixFilter)
               {
                  _loc6_ = _loc4_[_loc5_];
                  _loc7_ = {
                     "index":_loc5_,
                     "ratio":NaN
                  };
                  _loc7_.initMatrix = _loc6_.matrix;
                  _loc7_.matrix = this.getMatrix(param1);
                  param1.pluginData.ColorAdjustData = _loc7_;
               }
               _loc5_++;
            }
         }
         return param1.getValue(param2) - 1;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(!(param1.pluginData.ColorAdjustEnabled == null && enabled || param1.pluginData.ColorAdjustEnabled))
         {
            return param3;
         }
         var _loc8_:Object = param1.pluginData.ColorAdjustData;
         if(_loc8_ == null)
         {
            _loc8_ = this.initTarget(param1);
         }
         if(param6 == _loc8_.ratio)
         {
            return param3;
         }
         _loc8_.ratio = param6;
         param6 = param3 - param4;
         var _loc9_:Array = param1.target.filters;
         var _loc10_:ColorMatrixFilter = _loc9_[_loc8_.index] as ColorMatrixFilter;
         if(_loc10_ == null)
         {
            return param3;
         }
         var _loc11_:Array = _loc8_.initMatrix;
         var _loc12_:Array = _loc8_.matrix;
         if(param5 < 0)
         {
            _loc11_ = _loc12_;
            _loc12_ = _loc8_.initMatrix;
            param6 *= -1;
         }
         var _loc13_:Array = _loc10_.matrix;
         var _loc14_:uint = _loc13_.length;
         var _loc15_:uint = 0;
         while(_loc15_ < _loc14_)
         {
            _loc13_[_loc15_] = _loc11_[_loc15_] + (_loc12_[_loc15_] - _loc11_[_loc15_]) * param6;
            _loc15_++;
         }
         _loc10_.matrix = _loc13_;
         param1.target.filters = _loc9_;
         if(param7)
         {
            delete param1.pluginData.ColorAdjustData;
         }
         return NaN;
      }
      
      protected function getMatrix(param1:GTween) : ColorMatrix
      {
         var _loc2_:Number = this.fixValue(param1.getValue("brightness"));
         var _loc3_:Number = this.fixValue(param1.getValue("contrast"));
         var _loc4_:Number = this.fixValue(param1.getValue("saturation"));
         var _loc5_:Number = this.fixValue(param1.getValue("hue"));
         var _loc6_:ColorMatrix = new ColorMatrix();
         _loc6_.adjustColor(_loc2_,_loc3_,_loc4_,_loc5_);
         return _loc6_;
      }
      
      protected function initTarget(param1:GTween) : Object
      {
         var _loc2_:Array = param1.target.filters;
         var _loc3_:ColorMatrix = new ColorMatrix();
         _loc2_.push(new ColorMatrixFilter(_loc3_));
         param1.target.filters = _loc2_;
         var _loc4_:Object = {
            "index":_loc2_.length - 1,
            "ratio":NaN
         };
         _loc4_.initMatrix = _loc3_;
         _loc4_.matrix = this.getMatrix(param1);
         return param1.pluginData.ColorAdjustData = _loc4_;
      }
      
      protected function fixValue(param1:Number) : Number
      {
         return !!isNaN(param1) ? Number(0) : Number(param1);
      }
   }
}
