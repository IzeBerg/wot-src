package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EpicBattlesPrestigeProgressBlockVO extends DAAPIDataClass
   {
       
      
      public var prestigeLevel:int = -1;
      
      public var levelText:String = "";
      
      public var descText:String = "";
      
      public var canClaimVehicleReward:Boolean = false;
      
      public var blockStyle:String = "";
      
      public var useShortSeparatorLine:Boolean = false;
      
      public var lineSeparatorStyle:String = "";
      
      public var iconPath:String = "";
      
      public function EpicBattlesPrestigeProgressBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
