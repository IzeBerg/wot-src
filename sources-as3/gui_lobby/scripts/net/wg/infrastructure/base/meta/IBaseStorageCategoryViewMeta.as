package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseStorageCategoryViewMeta extends IEventDispatcher
   {
       
      
      function setActiveStateS(param1:Boolean) : void;
      
      function playInfoSoundS() : void;
      
      function scrolledToBottomS() : void;
      
      function as_showDummyScreen(param1:Boolean) : void;
      
      function as_showFilterWarning(param1:Object) : void;
      
      function as_getCardsDP() : Object;
      
      function as_scrollToItem(param1:int) : void;
   }
}
