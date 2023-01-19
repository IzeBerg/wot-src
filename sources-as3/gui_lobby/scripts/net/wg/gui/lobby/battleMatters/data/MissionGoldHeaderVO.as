package net.wg.gui.lobby.battleMatters.data
{
   import net.wg.gui.lobby.missions.data.CollapsedHeaderTitleBlockVO;
   import net.wg.gui.lobby.missions.data.MissionPackHeaderBaseVO;
   
   public class MissionGoldHeaderVO extends MissionPackHeaderBaseVO
   {
       
      
      public var info:String = "";
      
      public function MissionGoldHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override public function get titleBlockClass() : Class
      {
         return CollapsedHeaderTitleBlockVO;
      }
   }
}
