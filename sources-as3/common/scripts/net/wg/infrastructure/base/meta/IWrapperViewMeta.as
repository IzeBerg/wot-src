package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWrapperViewMeta extends IEventDispatcher
   {
       
      
      function onWindowCloseS() : void;
      
      function as_showWaiting(param1:String, param2:Object) : void;
      
      function as_hideWaiting() : void;
   }
}
