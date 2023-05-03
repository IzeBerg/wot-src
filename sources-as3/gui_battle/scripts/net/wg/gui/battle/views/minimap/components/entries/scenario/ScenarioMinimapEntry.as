package net.wg.gui.battle.views.minimap.components.entries.scenario
{
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.views.minimap.MinimapEntryController;
   
   public class ScenarioMinimapEntry extends BattleUIComponent
   {
      
      private static const DIVIDE_100:Number = 0.01;
       
      
      public var marker:ScenarioMinimapProgressCircle = null;
      
      public function ScenarioMinimapEntry()
      {
         super();
         this.marker.visible = true;
         MinimapEntryController.instance.registerScalableEntry(this);
      }
      
      override protected function onDispose() : void
      {
         MinimapEntryController.instance.unregisterScalableEntry(this);
         this.marker.dispose();
         this.marker = null;
         super.onDispose();
      }
      
      public function setProgress(param1:int) : void
      {
         this.marker.updateProgress(param1 * DIVIDE_100);
      }
   }
}
