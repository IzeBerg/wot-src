package net.wg.gui.lobby.missions.data
{
   public class MissionPackCategoryHeaderVO extends MissionPackHeaderBaseVO
   {
       
      
      public function MissionPackCategoryHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override public function get titleBlockClass() : Class
      {
         return CollapsedHeaderTitleBlockVO;
      }
   }
}
