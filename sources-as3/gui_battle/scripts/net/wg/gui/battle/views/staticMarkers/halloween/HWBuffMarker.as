package net.wg.gui.battle.views.staticMarkers.halloween
{
   import net.wg.gui.battle.views.staticMarkers.location.LocationMarker;
   
   public class HWBuffMarker extends LocationMarker
   {
      
      private static const SPAWNED_FRAME:int = 2;
      
      private static const SPAWN_FRAME:int = 1;
       
      
      public function HWBuffMarker()
      {
         super();
      }
      
      public function setIsSpawned(param1:Boolean) : void
      {
         HWBuffActionMarker(marker).setIsSpawned(param1);
         greenPoint.gotoAndStop(!!param1 ? SPAWNED_FRAME : SPAWN_FRAME);
      }
      
      public function setTimer(param1:String) : void
      {
         HWBuffActionMarker(marker).setTimer(param1);
      }
   }
}
