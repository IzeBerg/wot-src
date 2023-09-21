package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   public class EventHunterPanelListRight extends EventHunterPanelList
   {
      
      private static const LINKAGE:String = "EventHunterPanelListItemRightUI";
       
      
      public function EventHunterPanelListRight()
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
         return "[WG EventHunterPanelListRight]";
      }
   }
}
