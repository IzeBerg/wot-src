package net.wg.gui.battle.eventBattle.views.radialMenu.components
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.views.radialMenu.components.BackGround;
   
   public class EventBackGround extends BackGround
   {
       
      
      public function EventBackGround()
      {
         super();
      }
      
      protected function getBackGroundName() : String
      {
         return BATTLEATLAS.RADIAL_EVENT_HOLE;
      }
   }
}
