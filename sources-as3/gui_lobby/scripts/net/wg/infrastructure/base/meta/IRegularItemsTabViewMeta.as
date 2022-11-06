package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRegularItemsTabViewMeta extends IEventDispatcher
   {
       
      
      function navigateToStoreS() : void;
      
      function sellItemS(param1:Number) : void;
      
      function upgradeItemS(param1:Number) : void;
   }
}
