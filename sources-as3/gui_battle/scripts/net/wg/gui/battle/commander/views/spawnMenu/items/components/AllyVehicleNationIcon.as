package net.wg.gui.battle.commander.views.spawnMenu.items.components
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class AllyVehicleNationIcon extends BattleUIComponent
   {
       
      
      public var flagsMC:MovieClip = null;
      
      public function AllyVehicleNationIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.flagsMC = null;
         super.onDispose();
      }
   }
}
