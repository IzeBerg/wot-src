package net.wg.gui.battle.epicRandom.views.stats.components.playersPanel.list
{
   import net.wg.data.constants.Linkages;
   
   public class PlayersPanelListRight extends PlayersPanelList
   {
       
      
      public function PlayersPanelListRight()
      {
         super();
         selfBg.visible = false;
         initDogTag();
      }
      
      override public function toString() : String
      {
         return "[WG PlayersPanelListRight]";
      }
      
      override public function updateColorBlind() : void
      {
         var _loc1_:Boolean = App.colorSchemeMgr.getIsColorBlindS();
         spawnGroupIcon1.setColorblind(_loc1_);
         spawnGroupIcon2.setColorblind(_loc1_);
         spawnGroupIcon3.setColorblind(_loc1_);
         setGroupIcons();
         super.updateColorBlind();
      }
      
      override protected function get itemLinkage() : String
      {
         return Linkages.ER_PLAYERS_PANEL_RIGHT_ITEM_RENDERER_UI;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return true;
      }
   }
}
