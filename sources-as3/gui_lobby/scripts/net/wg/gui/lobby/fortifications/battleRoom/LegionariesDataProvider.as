package net.wg.gui.lobby.fortifications.battleRoom
{
   import net.wg.data.VoDAAPIDataProvider;
   import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesCandidateVO;
   
   public class LegionariesDataProvider extends VoDAAPIDataProvider
   {
       
      
      public function LegionariesDataProvider()
      {
         super(LegionariesCandidateVO);
      }
   }
}
