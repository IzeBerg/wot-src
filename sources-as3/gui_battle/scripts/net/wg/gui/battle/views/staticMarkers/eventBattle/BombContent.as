package net.wg.gui.battle.views.staticMarkers.eventBattle
{
   public class BombContent extends IndexedContent
   {
      
      private static const NORMAL_STATE_FRAME_LABEL:String = "bomb";
      
      private static const CAPTURED_STATE_FRAME_LABEL:String = "hunter";
       
      
      public var bombTimer:BombActionMarkerTimer = null;
      
      public function BombContent()
      {
         super();
      }
      
      public function updateTime(param1:Number, param2:Number, param3:Number) : void
      {
         this.bombTimer.updateTime(param1,param2,param3);
      }
      
      override protected function onDispose() : void
      {
         this.bombTimer.dispose();
         this.bombTimer = null;
         super.onDispose();
      }
      
      public function setIsCaptured(param1:Boolean) : void
      {
         icon.gotoAndStop(!!param1 ? CAPTURED_STATE_FRAME_LABEL : NORMAL_STATE_FRAME_LABEL);
      }
   }
}
