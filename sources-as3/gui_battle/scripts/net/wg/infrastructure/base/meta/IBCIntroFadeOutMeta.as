package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCIntroFadeOutMeta extends IEventDispatcher
   {
       
      
      function finishedS() : void;
      
      function as_startFadeout(param1:Number) : void;
   }
}
