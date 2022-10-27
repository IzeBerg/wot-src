package net.wg.gui.battle.views.staticMarkers.halloween
{
   import flash.text.TextField;
   import net.wg.gui.battle.views.staticMarkers.location.LocationActionMarker;
   
   public class HWBuffActionMarker extends LocationActionMarker
   {
      
      private static const SPAWNED_FRAME:int = 2;
      
      private static const SPAWN_FRAME:int = 1;
      
      private static const DISTANCE_Y:int = 24;
       
      
      public var timerField:TextField = null;
      
      public function HWBuffActionMarker()
      {
         super();
         setDistanceYPosition(DISTANCE_Y);
         locationTopElement.addChild(this.timerField);
      }
      
      override public function setActiveState(param1:String) : void
      {
         locationLineElement.gotoAndStop(param1);
      }
      
      override protected function onDispose() : void
      {
         HWBuffActionLine(locationLineElement).dispose();
         this.timerField = null;
         super.onDispose();
      }
      
      public function setIsSpawned(param1:Boolean) : void
      {
         this.timerField.visible = param1;
         locationTopElement.gotoAndStop(!!param1 ? SPAWNED_FRAME : SPAWN_FRAME);
         HWBuffActionLine(locationLineElement).setIsSpawned(param1);
      }
      
      public function setTimer(param1:String) : void
      {
         this.timerField.text = param1;
      }
   }
}
