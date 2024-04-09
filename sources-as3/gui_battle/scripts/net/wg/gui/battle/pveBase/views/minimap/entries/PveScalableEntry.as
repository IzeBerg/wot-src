package net.wg.gui.battle.pveBase.views.minimap.entries
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class PveScalableEntry extends BattleUIComponent
   {
       
      
      public function PveScalableEntry()
      {
         super();
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         super.onDispose();
      }
   }
}
