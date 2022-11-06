package net.wg.gui.battle.ranked.stats.components.playersPanel.list
{
   public class PlayersPanelListLeft extends PlayersPanelList
   {
      
      private static const LINKAGE:String = "RankedPlayersPanelListItemLeftUI";
       
      
      public function PlayersPanelListLeft()
      {
         super();
      }
      
      override protected function get itemLinkage() : String
      {
         return LINKAGE;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return false;
      }
      
      override public function toString() : String
      {
         return "[WG PlayersPanelListLeft]";
      }
   }
}
