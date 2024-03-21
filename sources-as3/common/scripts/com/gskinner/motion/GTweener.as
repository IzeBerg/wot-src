package com.gskinner.motion
{
   import flash.utils.Dictionary;
   
   public class GTweener
   {
      
      protected static var tweens:Dictionary;
      
      protected static var instance:GTweener;
      
      {
         staticInit();
      }
      
      public function GTweener()
      {
         super();
      }
      
      protected static function staticInit() : void
      {
         tweens = new Dictionary(true);
         instance = new GTweener();
         GTween.installPlugin(instance,["*"]);
      }
      
      public static function to(param1:Object = null, param2:Number = 1, param3:Object = null, param4:Object = null, param5:Object = null) : GTween
      {
         var _loc6_:GTween = new GTween(param1,param2,param3,param4,param5);
         add(_loc6_);
         return _loc6_;
      }
      
      public static function from(param1:Object = null, param2:Number = 1, param3:Object = null, param4:Object = null, param5:Object = null) : GTween
      {
         var _loc6_:GTween = to(param1,param2,param3,param4,param5);
         _loc6_.swapValues();
         return _loc6_;
      }
      
      public static function add(param1:GTween) : void
      {
         var _loc2_:Object = param1.target;
         var _loc3_:Array = tweens[_loc2_];
         if(_loc3_)
         {
            clearValues(_loc2_,param1.getValues());
         }
         else
         {
            _loc3_ = tweens[_loc2_] = [];
         }
         _loc3_.push(param1);
         param1.pluginData.GTweener = true;
      }
      
      public static function getTween(param1:Object, param2:String) : GTween
      {
         var _loc6_:GTween = null;
         var _loc3_:Array = tweens[param1];
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:uint = _loc3_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            if(!isNaN(_loc6_.getValue(param2)))
            {
               return _loc6_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public static function getTweens(param1:Object) : Array
      {
         return tweens[param1] || [];
      }
      
      public static function pauseTweens(param1:Object, param2:Boolean = true) : void
      {
         var _loc3_:Array = tweens[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:uint = _loc3_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_[_loc5_].paused = param2;
            _loc5_++;
         }
      }
      
      public static function resumeTweens(param1:Object) : void
      {
         pauseTweens(param1,false);
      }
      
      public static function remove(param1:GTween) : void
      {
         delete param1.pluginData.GTweener;
         var _loc2_:Array = tweens[param1.target];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:uint = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_] == param1)
            {
               _loc2_.splice(_loc4_,1);
               return;
            }
            _loc4_++;
         }
      }
      
      public static function removeTweens(param1:Object) : void
      {
         pauseTweens(param1);
         var _loc2_:Array = tweens[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:uint = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            delete _loc2_[_loc4_].pluginData.GTweener;
            _loc4_++;
         }
         delete tweens[param1];
      }
      
      protected static function clearValues(param1:Object, param2:Object) : void
      {
         var _loc3_:* = null;
         var _loc4_:GTween = null;
         for(_loc3_ in param2)
         {
            _loc4_ = getTween(param1,_loc3_);
            if(_loc4_)
            {
               _loc4_.deleteValue(_loc3_);
            }
         }
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         return param3;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(param7 && param1.pluginData.GTweener)
         {
            remove(param1);
         }
         return param3;
      }
   }
}
