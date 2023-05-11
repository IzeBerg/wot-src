package net.wg.gui.battle.comp7.stats.components.playersPanel.list
{
   public class Comp7PlayersPanelListRight extends Comp7PlayersPanelList
   {
      
      private static const LINKAGE:String = "Comp7PlayersPanelListItemRightUI";
      
      private static const NAME:String = "[WG Comp7PlayersPanelListRight]";
       
      
      public function Comp7PlayersPanelListRight()
      {
         super();
      }
      
      override public function toString() : String
      {
         return NAME;
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
