package net.wg.gui.lobby.fortifications.battleRoom
{
   public class FortBattleRoomWaitListSection extends SortieWaitListSection
   {
       
      
      public function FortBattleRoomWaitListSection()
      {
         super();
      }
      
      override protected function initializeDP() : void
      {
         candidatesDP = new LegionariesDataProvider();
      }
   }
}
