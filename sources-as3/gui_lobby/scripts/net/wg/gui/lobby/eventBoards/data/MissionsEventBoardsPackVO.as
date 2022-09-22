package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.gui.lobby.missions.data.MissionsPackVO;
   
   public class MissionsEventBoardsPackVO extends MissionsPackVO
   {
       
      
      public function MissionsEventBoardsPackVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function get dataClass() : Class
      {
         return MissionEventBoardsBodyVO;
      }
   }
}
