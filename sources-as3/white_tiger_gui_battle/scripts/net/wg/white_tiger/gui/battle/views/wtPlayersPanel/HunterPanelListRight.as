package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   public class HunterPanelListRight extends HunterPanelList
   {
      
      private static const LINKAGE:String = "HunterPanelListItemRightUI";
       
      
      public function HunterPanelListRight()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[MT HunterPanelListRight]";
      }
      
      override protected function get itemLinkage() : String
      {
         return LINKAGE;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return true;
      }
   }
}
