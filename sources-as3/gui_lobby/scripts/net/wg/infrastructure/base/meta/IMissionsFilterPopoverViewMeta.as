package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsFilterPopoverViewMeta extends IEventDispatcher
   {
       
      
      function changeFilterS(param1:Boolean, param2:Boolean) : void;
      
      function setDefaultFilterS() : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setState(param1:Object) : void;
      
      function as_enableDefaultBtn(param1:Boolean) : void;
   }
}
