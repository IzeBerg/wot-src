package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   
   public class CurrentFramePlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:CurrentFramePlugin;
       
      
      public function CurrentFramePlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(instance)
         {
            return;
         }
         instance = new CurrentFramePlugin();
         GTween.installPlugin(instance,["currentFrame"]);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         return param3;
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(!(param1.pluginData.CurrentFrameEnabled == null && enabled || param1.pluginData.CurrentFrameEnabled))
         {
            return param3;
         }
         var _loc8_:uint = Math.round(param4 + param5 * param6);
         if(param1.target.currentFrame != _loc8_)
         {
            param1.target.gotoAndStop(_loc8_);
         }
         return NaN;
      }
   }
}
