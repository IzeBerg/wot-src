package net.wg.gui.bootcamp
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.random.views.fragCorrelationBar.components.FCVehicleMarker;
   
   public class BCFCVehicleMarker extends FCVehicleMarker
   {
      
      private static const HINT_APPEAR:String = "appear";
       
      
      public var backAnim:MovieClip = null;
      
      public function BCFCVehicleMarker()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.backAnim = null;
         super.onDispose();
      }
      
      public function showHint() : void
      {
         this.backAnim.gotoAndPlay(HINT_APPEAR);
      }
   }
}
