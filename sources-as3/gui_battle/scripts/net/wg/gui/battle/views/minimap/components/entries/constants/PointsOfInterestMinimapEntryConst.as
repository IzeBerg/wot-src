package net.wg.gui.battle.views.minimap.components.entries.constants
{
   public class PointsOfInterestMinimapEntryConst
   {
      
      public static const POI_MARKER_BACK_ICON:String = "poiMarkerBack";
      
      private static const POI_MARKER_ICON_PREFIX:String = "poiMarkerIcon_";
       
      
      public function PointsOfInterestMinimapEntryConst()
      {
         super();
      }
      
      public static function getPOIMarkerIconByType(param1:uint) : String
      {
         return POI_MARKER_ICON_PREFIX + param1;
      }
   }
}
