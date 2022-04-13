package net.wg.gui.battle.commander.views.spawnMenu.items.components
{
   import net.wg.gui.battle.commander.views.common.VehicleTypeIcon;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class VehicleTypeProxy extends BattleUIComponent
   {
       
      
      public var icon:VehicleTypeIcon = null;
      
      public function VehicleTypeProxy()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
   }
}
