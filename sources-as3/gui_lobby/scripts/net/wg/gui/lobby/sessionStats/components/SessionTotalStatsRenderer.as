package net.wg.gui.lobby.sessionStats.components
{
   import net.wg.gui.lobby.components.StatisticsDashLineTextItemIRenderer;
   
   public class SessionTotalStatsRenderer extends SessionBattleStatsRenderer
   {
      
      public static const LINES_WIDTH:int = 240;
       
      
      public var dashLines:StatisticsDashLineTextItemIRenderer = null;
      
      public function SessionTotalStatsRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.dashLines.width = LINES_WIDTH;
         this.dashLines.useDefaultFormat = false;
      }
      
      override protected function onDispose() : void
      {
         this.dashLines.dispose();
         this.dashLines = null;
         super.onDispose();
      }
      
      override protected function applyData() : void
      {
         this.dashLines.label = data.label;
         this.dashLines.value = data.value;
         icon.source = data.icon;
      }
   }
}
