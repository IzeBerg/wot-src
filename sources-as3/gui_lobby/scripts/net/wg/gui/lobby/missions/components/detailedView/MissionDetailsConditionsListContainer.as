package net.wg.gui.lobby.missions.components.detailedView
{
   import net.wg.gui.lobby.missions.components.MissionConditionsListContainer;
   
   public class MissionDetailsConditionsListContainer extends MissionConditionsListContainer
   {
       
      
      public function MissionDetailsConditionsListContainer()
      {
         super();
      }
      
      override protected function useWideTextField(param1:Array) : Boolean
      {
         return param1.length <= 2;
      }
   }
}
