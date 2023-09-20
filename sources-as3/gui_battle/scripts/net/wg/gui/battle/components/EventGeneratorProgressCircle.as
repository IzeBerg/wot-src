package net.wg.gui.battle.components
{
   public class EventGeneratorProgressCircle extends BaseProgressCircle
   {
      
      private static const FRAME_LABEL_ONLINE:String = "online";
      
      private static const FRAME_LABEL_CAPTURING:String = "capture";
      
      private static const FRAME_LABEL_OFFLINE:String = "offline";
      
      private static const LAST_FRAME:int = 146;
       
      
      public function EventGeneratorProgressCircle()
      {
         super();
         this.resetGenerator();
      }
      
      override public function updateProgress(param1:Number) : void
      {
         if(currentFrameLabel != FRAME_LABEL_CAPTURING)
         {
            gotoAndStop(FRAME_LABEL_CAPTURING);
         }
         var _loc2_:int = param1 / 100 * LAST_FRAME | 0;
         progressCircle.gotoAndStop(_loc2_);
      }
      
      override protected function getCorrectState(param1:String) : String
      {
         return FRAME_LABEL_CAPTURING;
      }
      
      protected function get defaultEmptyFrame() : int
      {
         return LAST_FRAME;
      }
      
      public function resetGenerator() : void
      {
         gotoAndStop(FRAME_LABEL_ONLINE);
      }
      
      public function setGeneratorOffline() : void
      {
         gotoAndStop(FRAME_LABEL_OFFLINE);
      }
   }
}
