package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IExchangeXpWindowMeta extends IEventDispatcher
   {
       
      
      function getSubmitButtonEnableStateS(param1:int) : Boolean;
      
      function as_vehiclesDataChanged(param1:Object) : void;
      
      function as_totalExperienceChanged(param1:int) : void;
      
      function as_setWalletStatus(param1:Object, param2:Boolean) : void;
      
      function as_setTargetXP(param1:int) : void;
   }
}
