package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILegalInfoWindowMeta extends IEventDispatcher
   {
       
      
      function getLegalInfoS() : void;
      
      function onCancelClickS() : void;
      
      function as_setLegalInfo(param1:String) : void;
   }
}
