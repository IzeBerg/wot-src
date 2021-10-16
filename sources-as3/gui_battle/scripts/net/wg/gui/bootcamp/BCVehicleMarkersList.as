package net.wg.gui.bootcamp
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.FCVehicleMarker;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.VehicleMarkersList;
   
   public class BCVehicleMarkersList extends VehicleMarkersList
   {
       
      
      public function BCVehicleMarkersList(param1:MovieClip, param2:Boolean, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override protected function getMarkerLinkage() : String
      {
         return Linkages.BCFC_MARKER_ITEM;
      }
      
      public function showHint() : void
      {
         var _loc1_:FCVehicleMarker = null;
         for each(_loc1_ in vehicleMarkers)
         {
            BCFCVehicleMarker(_loc1_).showHint();
         }
      }
   }
}
