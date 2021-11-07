package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEULAMeta extends IEventDispatcher
   {
       
      
      function requestEULATextS() : void;
      
      function onLinkClickS(param1:String) : void;
      
      function onApplyS() : void;
      
      function as_setEULAText(param1:String) : void;
   }
}
