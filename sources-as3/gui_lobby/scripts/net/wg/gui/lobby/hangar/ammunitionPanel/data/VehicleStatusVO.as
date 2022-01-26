package net.wg.gui.lobby.hangar.ammunitionPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleStatusVO extends DAAPIDataClass
   {
       
      
      public var isElite:Boolean = false;
      
      public var tankType:String = "";
      
      public var vehicleLevel:String = "";
      
      public var vehicleName:String = "";
      
      public var message:String = "";
      
      public var rentAvailable:Boolean = false;
      
      public var roleId:int = -1;
      
      public var roleMessage:String = "";
      
      public var vehicleCD:int = -1;
      
      public var isNYVehicle:Boolean = false;
      
      public var nyBonusIcon:String = "";
      
      public var nyBonusValue:String = "";
      
      public var nyTooltip:String = "";
      
      public var isCreditsBonusVisible:Boolean = false;
      
      public var creditsAmount:String = "";
      
      public function VehicleStatusVO(param1:Object)
      {
         super(param1);
      }
   }
}
