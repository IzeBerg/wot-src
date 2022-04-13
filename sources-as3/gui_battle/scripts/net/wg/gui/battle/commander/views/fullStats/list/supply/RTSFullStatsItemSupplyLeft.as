package net.wg.gui.battle.commander.views.fullStats.list.supply
{
   import flash.text.TextFieldAutoSize;
   
   public class RTSFullStatsItemSupplyLeft extends AbstractRTSFullStatsItemSupply
   {
       
      
      public function RTSFullStatsItemSupplyLeft()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         count.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function get isAllyItem() : Boolean
      {
         return true;
      }
   }
}
