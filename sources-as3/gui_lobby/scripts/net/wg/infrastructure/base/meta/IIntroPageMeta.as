package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IIntroPageMeta extends IEventDispatcher
   {
       
      
      function stopVideoS() : void;
      
      function handleErrorS(param1:Object) : void;
      
      function as_playVideo(param1:Object) : void;
   }
}
