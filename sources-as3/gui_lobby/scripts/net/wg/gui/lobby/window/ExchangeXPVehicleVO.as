package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ExchangeXPVehicleVO extends DAAPIDataClass
   {
       
      
      public var id:Number = -1;
      
      public var vehicleType:String = "";
      
      public var vehicleName:String = "";
      
      public var xp:int = -1;
      
      public var xpStrValue:String = "";
      
      public var isSelectCandidate:Boolean;
      
      public var vehicleIco:String = "";
      
      public var nationIco:String = "";
      
      public function ExchangeXPVehicleVO(param1:Object)
      {
         super(param1);
      }
   }
}
