package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   
   public class SmartRotationPlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:SmartRotationPlugin;
      
      protected static var tweenProperties:Array = ["rotation","rotationX","rotationY","rotationZ"];
       
      
      public function SmartRotationPlugin()
      {
         super();
      }
      
      public static function install(param1:Array = null) : void
      {
         if(instance)
         {
            return;
         }
         instance = new SmartRotationPlugin();
         GTween.installPlugin(instance,param1 || tweenProperties,true);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         return param3;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(!(enabled && param1.pluginData.SmartRotationEnabled == null || param1.pluginData.SmartRotationEnabled))
         {
            return param3;
         }
         param5 %= 360;
         if(param5 > 180)
         {
            param5 -= 360;
         }
         else if(param5 < -180)
         {
            param5 += 360;
         }
         return param4 + param5 * param6;
      }
   }
}
