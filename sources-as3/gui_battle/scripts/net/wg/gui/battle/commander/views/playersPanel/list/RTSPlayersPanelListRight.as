package net.wg.gui.battle.commander.views.playersPanel.list
{
   public class RTSPlayersPanelListRight extends RTSPlayersPanelList
   {
      
      private static const LINKAGE:String = "RTSPlayersPanelListItemRightUI";
       
      
      public function RTSPlayersPanelListRight()
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
         return "[WG RTSPlayersPanelListRight]";
      }
   }
}
