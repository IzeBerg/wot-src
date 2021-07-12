package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesBrowserViewMeta extends IEventDispatcher
   {
       
      
      function onEscapePressS() : void;
      
      function onCloseBtnClickS() : void;
      
      function onFocusChangeS(param1:Boolean) : void;
      
      function viewSizeS(param1:Number, param2:Number) : void;
      
      function as_loadBrowser() : void;
   }
}
