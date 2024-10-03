package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   public class HunterPanelListLeft extends HunterPanelList
   {
      
      private static const LINKAGE:String = "HunterPanelListItemLeftUI";
       
      
      public function HunterPanelListLeft()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[MT HunterPanelListLeft]";
      }
      
      override protected function get itemLinkage() : String
      {
         return LINKAGE;
      }
      
      override protected function get isRightAligned() : Boolean
      {
         return false;
      }
   }
}
