package net.wg.gui.battle.halloween.playersList
{
   public class HWPlayersPanelListLeft extends HWPlayersPanelList
   {
      
      private static const LINKAGE:String = "HWPlayersPanelListItemLeftUI";
       
      
      public function HWPlayersPanelListLeft()
      {
         super();
      }
      
      override public function getItemHolderClass() : Class
      {
         return HWPlayersPanelListItemHolder;
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
