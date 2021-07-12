package net.wg.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TweenConstraintsVO extends DAAPIDataClass
   {
       
      
      public var moveDuration:int = -1;
      
      public var fadeDuration:int = -1;
      
      public var glowDuration:int = -1;
      
      public var shadowDuration:int = -1;
      
      public var blinkingDuration:int = -1;
      
      public var translationLength:int = -1;
      
      public var fadeAlphaMax:int = -1;
      
      public var fadeAlphaMin:int = -1;
      
      public var halfTurnDuration:int = -1;
      
      public var halfTurnDelay:int = -1;
      
      public function TweenConstraintsVO(param1:Object)
      {
         super(param1);
      }
   }
}
