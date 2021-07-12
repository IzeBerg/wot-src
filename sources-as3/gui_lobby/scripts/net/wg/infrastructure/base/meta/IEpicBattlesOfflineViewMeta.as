package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesOfflineViewMeta extends IEventDispatcher
   {
       
      
      function onCloseBtnClickS() : void;
      
      function onAboutButtonClickS() : void;
      
      function onEscapePressS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
