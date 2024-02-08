package net.wg.gui.battle.views.minimap.components.entries.epic
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class MapShortcutLabel extends BattleUIComponent
   {
       
      
      public var sectorOverview:MovieClip = null;
      
      public var shortcutLabel:ShortcutLabel = null;
      
      public function MapShortcutLabel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.shortcutLabel.dispose();
         this.shortcutLabel = null;
         this.sectorOverview = null;
         super.onDispose();
      }
      
      public function set label(param1:String) : void
      {
         this.shortcutLabel.label = param1;
      }
   }
}
