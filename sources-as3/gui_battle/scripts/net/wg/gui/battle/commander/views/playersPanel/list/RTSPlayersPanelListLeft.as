package net.wg.gui.battle.commander.views.playersPanel.list
{
   public class RTSPlayersPanelListLeft extends RTSPlayersPanelList
   {
      
      private static const LINKAGE:String = "RTSPlayersPanelListItemLeftUI";
       
      
      public function RTSPlayersPanelListLeft()
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
         return "[WG RTSPlayersPanelListLeft]";
      }
   }
}
