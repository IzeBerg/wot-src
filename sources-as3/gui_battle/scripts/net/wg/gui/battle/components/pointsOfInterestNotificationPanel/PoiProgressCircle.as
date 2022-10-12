package net.wg.gui.battle.components.pointsOfInterestNotificationPanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.components.poi.components.PoiProgressCircleWrapper;
   
   public class PoiProgressCircle extends PoiProgressCircleWrapper
   {
      
      private static const WIDTH:int = 64;
      
      private static const HEIGHT:int = 64;
       
      
      public function PoiProgressCircle()
      {
         progressLinkage = Linkages.POI_PROGRESS_BAR_UI;
         super();
      }
      
      override public function get width() : Number
      {
         return WIDTH;
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
   }
}
