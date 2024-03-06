package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesRewardsYearMeta extends IEventDispatcher
   {
       
      
      function onChooseRewardBtnClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setChooseRewardBtnCounter(param1:String) : void;
   }
}
