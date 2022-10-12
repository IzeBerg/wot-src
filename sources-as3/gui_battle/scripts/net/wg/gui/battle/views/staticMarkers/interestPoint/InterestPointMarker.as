package net.wg.gui.battle.views.staticMarkers.interestPoint
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class InterestPointMarker extends BattleUIComponent
   {
      
      private static const DIVIDE_100:Number = 0.01;
       
      
      public var marker:MarkerPoiProgressCircle = null;
      
      public function InterestPointMarker()
      {
         super();
         this.marker.visible = true;
      }
      
      override protected function onDispose() : void
      {
         this.marker.dispose();
         this.marker = null;
         super.onDispose();
      }
      
      public function setIsAlly(param1:Boolean) : void
      {
         this.marker.setIsAlly(param1);
      }
      
      public function setProgress(param1:Number) : void
      {
         this.marker.updateProgress(param1 * DIVIDE_100);
      }
      
      public function setStatus(param1:int, param2:int) : void
      {
         this.marker.setDuration(param2);
         this.marker.setStatusID(param1);
      }
      
      public function setType(param1:int) : void
      {
         this.marker.setIconType(param1);
      }
   }
}
