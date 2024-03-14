package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   import flash.media.SoundTransform;
   
   public class SoundTransformPlugin implements IGTweenPlugin
   {
      
      public static var enabled:Boolean = true;
      
      protected static var instance:SoundTransformPlugin;
      
      protected static var tweenProperties:Array = ["leftToLeft","leftToRight","pan","rightToLeft","rightToRight","volume"];
       
      
      public function SoundTransformPlugin()
      {
         super();
      }
      
      public static function install() : void
      {
         if(instance)
         {
            return;
         }
         instance = new SoundTransformPlugin();
         GTween.installPlugin(instance,tweenProperties,true);
      }
      
      public function init(param1:GTween, param2:String, param3:Number) : Number
      {
         if(!(enabled && param1.pluginData.SoundTransformEnabled == null || param1.pluginData.SoundTransformEnabled))
         {
            return param3;
         }
         return param1.target.soundTransform[param2];
      }
      
      public function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number
      {
         if(!(enabled && param1.pluginData.SoundTransformEnabled == null || param1.pluginData.SoundTransformEnabled))
         {
            return param3;
         }
         var _loc8_:SoundTransform = param1.target.soundTransform;
         _loc8_[param2] = param3;
         param1.target.soundTransform = _loc8_;
         return NaN;
      }
   }
}
