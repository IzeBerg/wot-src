package net.wg.gui.lobby.missions.components
{
   import net.wg.gui.lobby.missions.data.MissionPackCurrentVehicleHeaderVO;
   
   public class MissionPackCurrentVehicleHeader extends MissionPackHeaderBase
   {
      
      private static const HEIGHT:int = 95;
       
      
      public function MissionPackCurrentVehicleHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         height = HEIGHT;
      }
      
      override protected function get dataClass() : Class
      {
         return MissionPackCurrentVehicleHeaderVO;
      }
   }
}
