package net.wg.gui.battle.views.staticMarkers.scenario
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ScenarioMarker extends BattleUIComponent
   {
      
      private static const DIVIDE_100:Number = 0.01;
       
      
      public var marker:ScenarioMarkerProgressCircle = null;
      
      public function ScenarioMarker()
      {
         super();
         this.marker.visible = true;
      }
      
      override protected function onDispose() : void
      {
         this.marker.dispose();
         this.marker = null;
         super.onDispose();
      }
      
      public function setProgress(param1:Number) : void
      {
         this.marker.updateProgress(param1 * DIVIDE_100);
      }
   }
}
