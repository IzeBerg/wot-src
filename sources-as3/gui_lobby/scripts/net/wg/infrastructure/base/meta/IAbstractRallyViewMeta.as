package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAbstractRallyViewMeta extends IEventDispatcher
   {
       
      
      function viewSizeS(param1:Number, param2:Number) : void;
      
      function as_setPyAlias(param1:String) : void;
      
      function as_getPyAlias() : String;
      
      function as_loadBrowser() : void;
   }
}
