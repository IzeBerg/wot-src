package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ExchangeHeaderVO extends DAAPIDataClass
   {
       
      
      public var labelText:String = "";
      
      public var rateFromIcon:String = "";
      
      public var rateToIcon:String = "";
      
      public var rateFromTextColor:Number = -1;
      
      public var rateToTextColor:Number = -1;
      
      public function ExchangeHeaderVO(param1:Object)
      {
         super(param1);
      }
   }
}
