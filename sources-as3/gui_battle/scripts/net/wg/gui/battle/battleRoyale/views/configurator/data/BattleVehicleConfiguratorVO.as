package net.wg.gui.battle.battleRoyale.views.configurator.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleVehicleConfiguratorVO extends DAAPIDataClass
   {
       
      
      public var vehTypeIcon:String = "";
      
      public var vehName:String = "";
      
      public function BattleVehicleConfiguratorVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
