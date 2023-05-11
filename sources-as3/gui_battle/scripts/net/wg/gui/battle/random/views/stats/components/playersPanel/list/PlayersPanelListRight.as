package net.wg.gui.battle.random.views.stats.components.playersPanel.list
{
   public class PlayersPanelListRight extends PlayersPanelList
   {
      
      private static const LINKAGE:String = "PlayersPanelListItemRightUI";
       
      
      public function PlayersPanelListRight()
      {
         super();
      }
      
      override protected function get itemLinkage() : String
      {
         return LINKAGE;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return true;
      }
      
      override public function toString() : String
      {
         return "[WG PlayersPanelListRight]";
      }
   }
}
