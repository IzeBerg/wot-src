package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBrowserInViewComponentMeta extends IEventDispatcher
   {
       
      
      function viewSizeS(param1:Number, param2:Number) : void;
      
      function as_loadBrowser() : void;
      
      function as_setTitle(param1:String) : void;
   }
}
