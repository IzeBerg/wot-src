package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   
   public class AutoHidePlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:AutoHidePlugin;
      
      protected static var tweenProperties:Array = ["alpha"];
       
      
      public function AutoHidePlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(instance)
         {
            return;
         }
         instance = new AutoHidePlugin();
         GTween.installPlugin(instance,tweenProperties);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         return param3;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(param1.pluginData.AutoHideEnabled == null && enabled || param1.pluginData.AutoHideEnabled)
         {
            if(param1.target.visible != param3 > 0)
            {
               param1.target.visible = param3 > 0;
            }
         }
         return param3;
      }
   }
}
