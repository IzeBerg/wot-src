package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMessengerBarMeta extends IEventDispatcher
   {
       
      
      function channelButtonClickS() : void;
      
      function referralButtonClickS() : void;
      
      function sessionStatsButtonClickS() : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setVehicleCompareCartButtonVisible(param1:Boolean) : void;
      
      function as_setReferralProgramButtonVisible(param1:Boolean) : void;
      
      function as_setReferralButtonEnabled(param1:Boolean) : void;
      
      function as_setReferralBtnCounter(param1:int) : void;
      
      function as_setReferralBtnLimitIndication(param1:Boolean) : void;
      
      function as_openVehicleCompareCartPopover(param1:Boolean) : void;
      
      function as_showAddVehicleCompareAnim(param1:Object) : void;
      
      function as_setSessionStatsButtonVisible(param1:Boolean) : void;
      
      function as_setSessionStatsButtonEnable(param1:Boolean, param2:String) : void;
      
      function as_setSessionStatsButtonSettingsUpdate(param1:Boolean, param2:String) : void;
   }
}
