package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesInfoViewMeta extends IEventDispatcher
   {
       
      
      function onEscapePressS() : void;
      
      function onCloseBtnClickS() : void;
      
      function onManageAbilitiesBtnClickS() : void;
      
      function onPrestigeBtnClickS() : void;
      
      function onGameRewardsBtnClickS() : void;
      
      function onInfoBtnClickS() : void;
      
      function onShowRewardVehicleInGarageBtnClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_showInfoLines(param1:Boolean) : void;
      
      function as_showFinalRewardClaimed() : void;
   }
}
