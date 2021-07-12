package net.wg.gui.bootcamp
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.VehicleMarkersList;
   import net.wg.infrastructure.base.meta.impl.BCFragCorrelationBarMeta;
   
   public class BCFragCorrelationBar extends BCFragCorrelationBarMeta
   {
       
      
      public function BCFragCorrelationBar()
      {
         super();
      }
      
      override protected function createVehicleMarkersLists(param1:MovieClip, param2:Boolean, param3:String) : VehicleMarkersList
      {
         return new BCVehicleMarkersList(param1,param2,param3);
      }
      
      public function as_showHint() : void
      {
         BCVehicleMarkersList(enemyVehicleMarkersList).showHint();
         BCVehicleMarkersList(allyVehicleMarkersList).showHint();
      }
   }
}
