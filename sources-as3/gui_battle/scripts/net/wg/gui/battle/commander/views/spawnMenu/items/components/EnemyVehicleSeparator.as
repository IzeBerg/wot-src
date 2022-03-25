package net.wg.gui.battle.commander.views.spawnMenu.items.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.commander.views.spawnMenu.items.StagedItem;
   
   public class EnemyVehicleSeparator extends StagedItem
   {
       
      
      public var separator:MovieClip = null;
      
      public function EnemyVehicleSeparator()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.separator = null;
         super.onDispose();
      }
   }
}
