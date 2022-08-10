package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISessionStatsSettingsMeta extends IEventDispatcher
   {
       
      
      function onClickApplyBtnS() : void;
      
      function onClickBackBtnS() : void;
      
      function onClickResetBtnS() : void;
      
      function onSettingsInputChangedS(param1:String, param2:int) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setControlsState(param1:Object) : void;
      
      function as_setBattleSettingsStatus(param1:String, param2:Boolean) : void;
   }
}
