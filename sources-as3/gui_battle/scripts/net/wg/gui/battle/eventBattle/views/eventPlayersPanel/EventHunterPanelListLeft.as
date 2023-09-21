package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   public class EventHunterPanelListLeft extends EventHunterPanelList
   {
      
      private static const LINKAGE:String = "EventHunterPanelListItemLeftUI";
       
      
      public function EventHunterPanelListLeft()
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
         return "[WG EventHunterPanelListLeft]";
      }
   }
}
