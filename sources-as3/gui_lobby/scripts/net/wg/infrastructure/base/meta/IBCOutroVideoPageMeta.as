package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCOutroVideoPageMeta extends IEventDispatcher
   {
       
      
      function videoFinishedS(param1:Boolean = false) : void;
      
      function handleErrorS(param1:String) : void;
      
      function as_playVideo(param1:Object) : void;
      
      function as_pausePlayback() : void;
      
      function as_resumePlayback() : void;
   }
}
