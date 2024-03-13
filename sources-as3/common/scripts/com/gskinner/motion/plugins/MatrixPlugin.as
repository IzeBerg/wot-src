package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   import flash.geom.Matrix;
   
   public class MatrixPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:MatrixPlugin;
      
      protected static var tweenProperties:Array = ["a","b","c","d","tx","ty"];
       
      
      public function MatrixPlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(instance)
         {
            return;
         }
         instance = new MatrixPlugin();
         GTween.installPlugin(instance,tweenProperties,true);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         if(!(enabled && param1.pluginData.MatrixEnabled == null || param1.pluginData.MatrixEnabled))
         {
            return param3;
         }
         return param1.target.transform.matrix[param2];
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(!(enabled && param1.pluginData.MatrixEnabled == null || param1.pluginData.MatrixEnabled))
         {
            return param3;
         }
         var _loc8_:Matrix = param1.target.transform.matrix;
         _loc8_[param2] = param3;
         param1.target.transform.matrix = _loc8_;
         return NaN;
      }
   }
}
