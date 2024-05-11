package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IStorageCategoryForSellViewMeta extends IEventDispatcher
   {
       
      
      function navigateToStoreS() : void;
      
      function selectItemS(param1:Number, param2:Boolean) : void;
      
      function selectAllS(param1:Boolean) : void;
      
      function sellItemS(param1:Number) : void;
      
      function sellAllS() : void;
      
      function as_init(param1:Object) : void;
   }
}
