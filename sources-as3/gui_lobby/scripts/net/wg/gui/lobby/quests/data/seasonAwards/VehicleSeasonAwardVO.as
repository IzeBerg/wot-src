package net.wg.gui.lobby.quests.data.seasonAwards
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleSeasonAwardVO extends DAAPIDataClass
   {
       
      
      public var iconPath:String = "";
      
      public var vehicleType:String = "";
      
      public var name:String = "";
      
      public var buttonText:String = "";
      
      public var vehicleId:Number = -1.0;
      
      public var buttonTooltipId:String = "";
      
      public var tokensCountText:String = "";
      
      public var tokensCountTooltip:String = "";
      
      public function VehicleSeasonAwardVO(param1:Object)
      {
         super(param1);
      }
   }
}
