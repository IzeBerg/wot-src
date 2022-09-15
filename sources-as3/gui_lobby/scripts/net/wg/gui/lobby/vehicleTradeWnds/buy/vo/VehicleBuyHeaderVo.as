package net.wg.gui.lobby.vehicleTradeWnds.buy.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleBuyHeaderVo extends DAAPIDataClass
   {
       
      
      public var userName:String = "";
      
      public var icon:String = "";
      
      public var level:Number = 0;
      
      public var isElite:Boolean = false;
      
      public var isPremium:Boolean = false;
      
      public var type:String = "";
      
      public var nationID:Number = 0;
      
      public var intCD:Number = -1;
      
      public var levelStr:String = "";
      
      public var description:String = "";
      
      public function VehicleBuyHeaderVo(param1:Object)
      {
         super(param1);
      }
   }
}
