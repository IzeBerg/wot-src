package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   
   public class SnappingPlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:SnappingPlugin;
      
      protected static var tweenProperties:Array = ["x","y"];
       
      
      public function SnappingPlugin()
      {
         super();
      }
      
      public static function install(param1:Array = null) : void
      {
         if(instance)
         {
            return;
         }
         instance = new SnappingPlugin();
         GTween.installPlugin(instance,param1 || tweenProperties,true);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         return param3;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(!(enabled && param1.pluginData.SnappingEnabled == null || param1.pluginData.SnappingEnabled))
         {
            return param3;
         }
         return Math.round(param3);
      }
   }
}
