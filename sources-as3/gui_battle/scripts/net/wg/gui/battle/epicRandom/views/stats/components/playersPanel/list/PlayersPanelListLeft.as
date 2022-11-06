package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list
{
   import net.wg.data.constants.Linkages;
   
   public class PlayersPanelListLeft extends PlayersPanelList
   {
       
      
      public function PlayersPanelListLeft()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG PlayersPanelListLeft]";
      }
      
      override protected function get itemLinkage() : String
      {
         return Linkages.ER_PLAYERS_PANEL_LEFT_ITEM_RENDERER_UI;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return false;
      }
   }
}
