package net.wg.gui.notification.custom.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SMExchangeRatePersonalDiscountVO extends DAAPIDataClass
   {
       
      
      public var type:String = "";
      
      public var format:String = "";
      
      public var endTime:int = -1;
      
      public var discountPercent:int = -1;
      
      public function SMExchangeRatePersonalDiscountVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
