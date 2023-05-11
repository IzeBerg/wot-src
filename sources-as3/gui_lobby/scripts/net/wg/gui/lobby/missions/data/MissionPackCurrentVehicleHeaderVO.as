package net.wg.gui.lobby.missions.data
{
   public class MissionPackCurrentVehicleHeaderVO extends MissionPackHeaderBaseVO
   {
       
      
      public function MissionPackCurrentVehicleHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override public function get titleBlockClass() : Class
      {
         return CurrentVehicleHeaderTitleBlockVO;
      }
   }
}
