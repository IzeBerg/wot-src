package net.wg.gui.lobby.fortifications.data.battleRoom
{
   import net.wg.gui.rally.vo.RallyCandidateVO;
   
   public class LegionariesCandidateVO extends RallyCandidateVO
   {
       
      
      public var headerText:String = "";
      
      public var emptyRender:Boolean = false;
      
      public var headerToolTip:String = "";
      
      public var isLegionaries:Boolean = false;
      
      public function LegionariesCandidateVO(param1:Object)
      {
         super(param1);
      }
   }
}
