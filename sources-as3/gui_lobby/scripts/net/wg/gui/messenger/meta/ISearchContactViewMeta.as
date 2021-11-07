package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISearchContactViewMeta extends IEventDispatcher
   {
       
      
      function searchS(param1:Object) : void;
      
      function as_getSearchDP() : Object;
      
      function as_setSearchResultText(param1:String) : void;
      
      function as_setSearchDisabled(param1:Number) : void;
   }
}
