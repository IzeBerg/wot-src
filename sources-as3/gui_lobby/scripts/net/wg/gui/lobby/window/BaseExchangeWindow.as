package net.wg.gui.lobby.window
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.meta.IBaseExchangeWindowMeta;
   import net.wg.infrastructure.base.meta.impl.BaseExchangeWindowMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseExchangeWindow extends BaseExchangeWindowMeta implements IBaseExchangeWindowMeta
   {
      
      protected static const TOTAL_PRIMARY_CURRENCY_INVALID:String = "TotalPrimaryCurrencyInv";
      
      protected static const RATES_INVALID:String = "ratesInv";
       
      
      protected var totalPrimaryCurrency:int = -1;
      
      protected var rate:uint;
      
      protected var actionRate:uint;
      
      protected var actualRate:uint = 1;
      
      protected var actionMode:Boolean = false;
      
      public function BaseExchangeWindow()
      {
         super();
      }
      
      override protected function exchangeRate(param1:BaseExchangeWindowRateVO) : void
      {
         if(this.rate != param1.value || this.actionRate != param1.actionValue)
         {
            this.rate = param1.value;
            this.actionRate = param1.actionValue;
            this.actionMode = param1.actionMode;
            this.actualRate = this.rate != this.actionRate && this.actionRate != 0 ? uint(this.actionRate) : uint(this.rate);
            invalidate(RATES_INVALID);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(RATES_INVALID))
         {
            this.applyRatesChanges();
         }
         if(isInvalid(TOTAL_PRIMARY_CURRENCY_INVALID))
         {
            this.applyPrimaryCurrencyChange();
         }
      }
      
      public function as_setPrimaryCurrency(param1:Number) : void
      {
         if(this.totalPrimaryCurrency != param1)
         {
            this.totalPrimaryCurrency = param1;
            invalidate(TOTAL_PRIMARY_CURRENCY_INVALID);
         }
      }
      
      protected function applyPrimaryCurrencyChange() : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function applyRatesChanges() : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
   }
}
