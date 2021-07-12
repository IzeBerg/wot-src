package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILinkedSetDetailsOverlayMeta extends IEventDispatcher
   {
       
      
      function startClickS(param1:String) : void;
      
      function setPageS(param1:int) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setDataVideo(param1:Object) : void;
      
      function as_setColorPages(param1:Array) : void;
      
      function as_setPage(param1:int) : void;
   }
}
