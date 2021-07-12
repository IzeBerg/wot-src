package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesPrestigeViewMeta extends IEventDispatcher
   {
       
      
      function onCloseBtnClickS() : void;
      
      function onEscapePressS() : void;
      
      function onResetBtnClickS() : void;
      
      function onBackBtnClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_showSuccessfullPrestige() : void;
   }
}
