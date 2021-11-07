package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISessionStatsOverviewMeta extends IEventDispatcher
   {
       
      
      function onClickMoreBtnS() : void;
      
      function onClickResetBtnS() : void;
      
      function onClickSettingsBtnS() : void;
      
      function onExpandedS(param1:Boolean) : void;
      
      function onTabSelectedS(param1:String) : void;
      
      function onCounterUpdatedS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setButtonsState(param1:Array) : void;
      
      function as_setHeaderTooltip(param1:String) : void;
   }
}
