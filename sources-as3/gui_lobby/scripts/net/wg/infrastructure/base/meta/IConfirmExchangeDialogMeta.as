package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IConfirmExchangeDialogMeta extends IEventDispatcher
   {
       
      
      function exchangeS(param1:Number) : void;
      
      function onSelectedAmountChangedS(param1:Number, param2:Number) : void;
      
      function openDiscountInfoPageS() : void;
      
      function as_update(param1:Object) : void;
      
      function as_setExchangeValues(param1:Number, param2:Number, param3:int) : void;
   }
}
