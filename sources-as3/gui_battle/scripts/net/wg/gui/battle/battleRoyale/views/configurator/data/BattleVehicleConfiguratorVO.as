package net.wg.gui.battle.battleRoyale.views.configurator.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleVehicleConfiguratorVO extends DAAPIDataClass
   {
       
      
      public var nationIcon:String = "";
      
      public var vehName:String = "";
      
      public var weakPointsText:String = "";
      
      public var alertIcon:String = "";
      
      public function BattleVehicleConfiguratorVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
