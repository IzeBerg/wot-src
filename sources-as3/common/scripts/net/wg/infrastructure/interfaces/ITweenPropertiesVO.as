package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   
   public interface ITweenPropertiesVO extends ISimpleTweenPropertiesVO
   {
       
      
      function setPosition(param1:int) : void;
      
      function setDuration(param1:int) : void;
      
      function setGlobalDelay(param1:int) : void;
      
      function setLocalDelay(param1:int) : void;
      
      function setTarget(param1:DisplayObject) : void;
      
      function setActionAfterRemoveFromStage(param1:String) : void;
      
      function setLoop(param1:Boolean) : void;
      
      function setHandler(param1:ITweenHandler) : void;
      
      function setPaused(param1:Boolean) : void;
      
      function setX(param1:Number) : void;
      
      function setY(param1:Number) : void;
      
      function setScaleX(param1:Number) : void;
      
      function setScaleY(param1:Number) : void;
      
      function setAlpha(param1:Number) : void;
      
      function setRotation(param1:Number) : void;
      
      function setTweenIdx(param1:int) : void;
   }
}
