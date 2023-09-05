package net.wg.gui.battle.views.staticMarkers.location
{
   import flash.geom.Point;
   
   public class FlagLocationActionMarker extends LocationActionMarker
   {
      
      private static const FLAG_STICKY_MARKER_UI:String = "FlagStickyMarkerUI";
      
      private static const FLAG_REPLY_POSITION_X:Number = 32;
      
      private static const FLAG_REPLY_POSITION_Y:Number = -8;
       
      
      public function FlagLocationActionMarker()
      {
         super();
      }
      
      override protected function get stickyMarkerClassLinkage() : String
      {
         return FLAG_STICKY_MARKER_UI;
      }
      
      override protected function get getReplyPosition() : Point
      {
         return new Point(FLAG_REPLY_POSITION_X,FLAG_REPLY_POSITION_Y);
      }
   }
}
