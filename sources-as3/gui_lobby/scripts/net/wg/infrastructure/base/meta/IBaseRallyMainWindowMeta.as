package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseRallyMainWindowMeta extends IEventDispatcher
   {
       
      
      function onBackClickS() : void;
      
      function getClientIDS() : Number;
   }
}
