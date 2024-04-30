package net.wg.gui.battle.historicalBattles.staticMarkers.controlPoint
{
   import flash.geom.Point;
   import net.wg.gui.battle.views.staticMarkers.location.LocationActionMarker;
   
   public class HBLocationActionMarker extends LocationActionMarker
   {
      
      private static const HISTORICAL_STICKY_MARKER_UI:String = "HistoricalStickyMarkerUI";
      
      private static const HB_REPLY_POSITION_X:Number = 32;
      
      private static const HB_REPLY_POSITION_Y:Number = -8;
       
      
      public function HBLocationActionMarker()
      {
         super();
      }
      
      override protected function get stickyMarkerClassLinkage() : String
      {
         return HISTORICAL_STICKY_MARKER_UI;
      }
      
      override protected function get getReplyPosition() : Point
      {
         return new Point(HB_REPLY_POSITION_X,HB_REPLY_POSITION_Y);
      }
   }
}
