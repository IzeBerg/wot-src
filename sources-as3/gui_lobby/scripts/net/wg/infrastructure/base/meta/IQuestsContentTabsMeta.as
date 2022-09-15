package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IQuestsContentTabsMeta extends IEventDispatcher
   {
       
      
      function onSelectTabS(param1:String) : void;
      
      function as_selectTab(param1:int) : void;
      
      function as_setTabs(param1:Object) : void;
   }
}
