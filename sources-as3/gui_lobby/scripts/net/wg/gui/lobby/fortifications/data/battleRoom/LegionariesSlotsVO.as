package net.wg.gui.lobby.fortifications.data.battleRoom
{
   import net.wg.gui.interfaces.IRallyCandidateVO;
   import net.wg.gui.rally.vo.RallySlotVO;
   
   public class LegionariesSlotsVO extends RallySlotVO
   {
       
      
      public function LegionariesSlotsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function initCandidateVO(param1:Object) : IRallyCandidateVO
      {
         return new LegionariesCandidateVO(param1);
      }
   }
}
