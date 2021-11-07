package net.wg.infrastructure.managers
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITweenManagerHelper extends IDisposable
   {
       
      
      function getFadeDuration() : int;
      
      function getFadeDurationSlow() : int;
      
      function getFadeDurationFast() : int;
      
      function getMoveDuration() : int;
      
      function getMoveDurationSlow() : int;
      
      function getMoveDurationFast() : int;
      
      function getGlowDuration() : int;
      
      function getGlowDurationSlow() : int;
      
      function getShadowDuration() : int;
      
      function getShadowDurationFast() : int;
      
      function getShadowDurationSlow() : int;
      
      function getBlinkingDuration() : int;
      
      function getTranslationLength() : int;
      
      function getFadeAlphaMax() : int;
      
      function getFadeAlphaMin() : int;
      
      function getHalfTurnDuration() : int;
      
      function getHalfTurnDelay() : int;
      
      function getSimilarTypes(param1:String) : Vector.<String>;
   }
}
