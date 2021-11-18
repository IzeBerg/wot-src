package net.wg.gui.lobby.tradeIn.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TradeOffWidgetVO extends DAAPIDataClass
   {
       
      
      public var vehicleNationFlag:String = "";
      
      public var vehicleType:String = "";
      
      public var vehicleLevel:String = "";
      
      public var vehicleIcon:String = "";
      
      public var vehicleTitle:String = "";
      
      public var showTradeOff:Boolean = true;
      
      public var available:Boolean = true;
      
      public var isPersonal:Boolean = false;
      
      public function TradeOffWidgetVO(param1:Object)
      {
         super(param1);
      }
   }
}
