package net.wg.gui.battle.halloween.playersList
{
   public class HWPlayersPanelListRight extends HWPlayersPanelList
   {
      
      private static const LINKAGE:String = "HWPlayersPanelListItemRightUI";
       
      
      public function HWPlayersPanelListRight()
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
         return true;
      }
   }
}
