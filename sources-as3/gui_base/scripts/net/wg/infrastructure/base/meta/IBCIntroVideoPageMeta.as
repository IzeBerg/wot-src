package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCIntroVideoPageMeta extends IEventDispatcher
   {
       
      
      function videoStartedS() : void;
      
      function videoFinishedS() : void;
      
      function goToBattleS() : void;
      
      function skipBootcampS() : void;
      
      function handleErrorS(param1:Object) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_updateProgress(param1:Number) : void;
      
      function as_loaded() : void;
      
      function as_showIntroPage(param1:Boolean, param2:Boolean) : void;
      
      function as_pausePlayback() : void;
      
      function as_resumePlayback() : void;
   }
}
