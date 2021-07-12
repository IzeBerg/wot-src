package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesWelcomeBackViewMeta extends IEventDispatcher
   {
       
      
      function onBackBtnClickedS() : void;
      
      function onCloseBtnClickedS() : void;
      
      function onContinueBtnClickedS() : void;
      
      function onChangesLinkClickedS() : void;
      
      function playVideoS() : void;
      
      function as_setInitData(param1:Object) : void;
   }
}
