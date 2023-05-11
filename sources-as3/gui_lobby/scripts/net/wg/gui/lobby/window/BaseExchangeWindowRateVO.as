package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BaseExchangeWindowRateVO extends DAAPIDataClass
   {
       
      
      public var value:Number = -1;
      
      public var actionValue:Number = -1;
      
      public var actionMode:Boolean = false;
      
      public function BaseExchangeWindowRateVO(param1:Object)
      {
         super(param1);
      }
   }
}
