package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IExchangeFreeToTankmanXpWindowMeta extends IEventDispatcher
   {
       
      
      function applyS() : void;
      
      function onValueChangedS(param1:Object) : void;
      
      function calcValueRequestS(param1:Number) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setCalcValueResponse(param1:Number, param2:Object) : void;
      
      function as_setWalletStatus(param1:Object) : void;
   }
}
