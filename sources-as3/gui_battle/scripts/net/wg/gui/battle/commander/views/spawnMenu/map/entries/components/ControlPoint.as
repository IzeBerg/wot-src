package net.wg.gui.battle.commander.views.spawnMenu.map.entries.components
{
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ControlPoint extends BattleUIComponent
   {
       
      
      public var icon:BattleAtlasSprite = null;
      
      public function ControlPoint()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         super.onDispose();
      }
   }
}
