package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesAfterBattleViewMeta extends IEventDispatcher
   {
       
      
      function onIntroStartsPlayingS() : void;
      
      function onRibbonStartsPlayingS() : void;
      
      function onNextBtnClickS() : void;
      
      function onCloseBtnClickS() : void;
      
      function onRewardsBtnClickS() : void;
      
      function onEscapePressS() : void;
      
      function onProgressBarStartAnimS() : void;
      
      function onProgressBarCompleteAnimS() : void;
      
      function as_setData(param1:Object) : void;
   }
}
