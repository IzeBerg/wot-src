package com.gskinner.motion.plugins
{
   import com.gskinner.motion.GTween;
   
   public interface IGTweenPlugin
   {
       
      
      function init(param1:GTween, param2:String, param3:Number) : Number;
      
      function tween(param1:GTween, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Boolean) : Number;
   }
}
