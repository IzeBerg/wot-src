package net.wg.gui.lobby.hangar.quests
{
   public class QuestFlagEntryPointBase extends HeaderSecondaryWidgetInject
   {
      
      private static const WIDTH:int = 66;
      
      private static const HEIGHT:int = 113;
      
      private static const MARGIN:int = 2;
       
      
      public function QuestFlagEntryPointBase()
      {
         super();
         setManageSize(true);
         setSize(WIDTH + 2 * MARGIN,HEIGHT + 2 * MARGIN);
      }
   }
}
